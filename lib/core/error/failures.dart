
import 'package:shop_project/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Failure {
  final AppException exception;

  final FailureInterpretation interpretation;

  Failure({required this.exception})
    : interpretation = FailureInterpretationHelper().getInterpretation(
        exception,
      );
}

class FailureInterpretation {
  final String title;
  final String message;

  FailureInterpretation({required this.title, required this.message});
}

class FailureInterpretationHelper {
  FailureInterpretation getInterpretation(AppException exception) {
    switch (exception) {
      case BadRequestException():
        return fromBadRequest(exception);
      case UnauthorizedException():
        return fromUnauthorized(exception);
      case NotFoundException():
        return fromNotFound(exception);
      case InternalServerErrorException():
        return fromInternalServerError(exception);
      case ServiceUnavailableException():
        return fromServiceUnavailable(exception);
      case NetworkException():
        return fromNetwork(exception);
      default:
        return fromUnexpected(exception);
    }
  }

  FailureInterpretation fromBadRequest(BadRequestException exception) {
    return FailureInterpretation(
      title: "Error",
      message: exception.message ?? "Sorry, something went wrong.",
    );
  }



  FailureInterpretation fromUnauthorized(UnauthorizedException exception) {
    String displayMessage = "Please login to continue";
    if(exception.exception is AuthException){
      final supabaseError = exception.exception as AuthException;
      displayMessage = supabaseError.message;
    }
    return FailureInterpretation(
      title: "Unauthorized",
      message: displayMessage,
    );
  }

  FailureInterpretation fromNotFound(NotFoundException exception) {
    return FailureInterpretation(
      title: "Not Found",
      message: "The requested resource was not found.",
    );
  }

  FailureInterpretation fromInternalServerError(
    InternalServerErrorException exception,
  ) {
    return FailureInterpretation(
      title: "Error",
      message: "Sorry, something went wrong.",
    );
  }

  FailureInterpretation fromServiceUnavailable(
    ServiceUnavailableException exception,
  ) {
    return FailureInterpretation(
      title: "Error",
      message:
          "Sorry, our service is currently unavailable, please try again later.",
    );
  }

  FailureInterpretation fromNetwork(NetworkException exception) {
    return FailureInterpretation(
      title: "Connection Error",
      message: "Please check your internet connection and try again",
    );
  }

  FailureInterpretation fromUnexpected(AppException exception) {
    return FailureInterpretation(
      title: "Error",
      message: "Sorry, something went wrong.",
    );
  }
}

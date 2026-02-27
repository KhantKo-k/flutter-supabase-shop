abstract base class AppException{
  final dynamic exception;
  final StackTrace? stackTrace;

  AppException({
    required this.exception,
    this.stackTrace
  });

  @override
  String toString() => '$runtimeType: $exception'; 
}

final class BadRequestException extends AppException{
  final String? message;
  BadRequestException({
    required super.exception,
    required super.stackTrace,
    required this.message
  });
}

final class UnauthorizedException extends AppException{
  UnauthorizedException({
    required super.exception,
    required super.stackTrace,
  });
}

final class NotFoundException extends AppException{
  NotFoundException({
    required super.exception,
    required super.stackTrace,
  });
}

final class InternalServerErrorException extends AppException{
  InternalServerErrorException({
    required super.exception,
    required super.stackTrace,
  });
}

final class ServiceUnavailableException extends AppException{
  ServiceUnavailableException({
    required super.exception,
    required super.stackTrace,
  });
}

final class NetworkException extends AppException{
  NetworkException({
    required super.exception,
    required super.stackTrace,
  });
}

final class SystemException extends AppException{
  SystemException({
    required super.exception,
    required super.stackTrace,
  });
}

final class ParseException extends AppException{
  ParseException({
    required super.exception,
    required super.stackTrace,
  });
}

final class UnknownException extends AppException{
  UnknownException({
    required super.exception,
    required super.stackTrace,
  });
}
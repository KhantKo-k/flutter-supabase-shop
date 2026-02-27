import 'package:shop_project/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppExceptionFactory{
  static AppException fromException(dynamic exception, StackTrace? stackTrace){
    switch (exception){
      case FormatException():
        return ParseException(exception: exception, stackTrace: stackTrace);
      case AuthException():
        return UnauthorizedException(exception: exception, stackTrace: stackTrace);
      case OutOfMemoryError():
      case StackOverflowError():
        return SystemException(exception: exception, stackTrace: stackTrace);
      case PostgrestException():
        return PostgrestFactory.fromPostgrest(exception, stackTrace);
      default:
        return UnknownException(exception: exception, stackTrace: stackTrace);
    }
  }
}

class PostgrestFactory{
  static AppException fromPostgrest(PostgrestException e,StackTrace? s){
    return switch(e.code){
      '404' || 'PGRST116' => NotFoundException(exception: e, stackTrace: s),
      '401' => UnauthorizedException(exception: e, stackTrace: s),
      '503' => ServiceUnavailableException(exception: e, stackTrace: s),
      _ => BadRequestException(exception: e, stackTrace: s, message: e.message),
    };
  }
}
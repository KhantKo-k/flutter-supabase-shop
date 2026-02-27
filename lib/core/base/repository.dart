

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_project/core/error/exception_factory.dart';
import 'package:shop_project/core/error/failures.dart';

abstract class Repository {
  Future<Either<Failure, T>> on<T>(Future<T> Function() fn) async {
    try{
      final result = await fn();
      return Right(result);
    }catch (e, s){
      final appException = AppExceptionFactory.fromException(e,s);
      debugPrint("Handled Exception: ${appException.toString()}");
      return Left(Failure(exception: appException));
    }
  }
}
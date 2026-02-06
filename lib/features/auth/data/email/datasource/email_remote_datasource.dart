import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/email/models/email_identity_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class EmailRemoteDatasource {
  Future<Either<Failure, EmailIdentityModel>> checkEmail(String email);
}

class EmailRemoteDatasourceImpl implements EmailRemoteDatasource {
  final SupabaseClient client;

  EmailRemoteDatasourceImpl(this.client);

  @override
  Future<Either<Failure, EmailIdentityModel>> checkEmail(String email) async {
    try {
      final repsonse = await client
          .from('profiles')
          .select('email, username, avatar_url')
          .eq('email', email)
          .single();

      return right(EmailIdentityModel.fromJson(repsonse));
    } on PostgrestException catch (_) {
      return left(const AuthFailure('Email not registered'));
    } on SocketException {
      return left(
        const NetworkFailure('Please check your internet connection'),
      );
    } catch (_) {
      return left(const UnknownFailure('Something went wrong'));
    }
  }
}

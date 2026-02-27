import 'package:equatable/equatable.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';

abstract class EmailState extends Equatable{
  const EmailState();

  @override
  List<Object?> get props => [];
}

class EmailInitial extends EmailState{}

class EmailLoading extends EmailState{}

class EmailSuccess extends EmailState{
  final EmailIdentity profile;

  const EmailSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class EmailFailure extends EmailState{
  final Failure failure;

  const EmailFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}


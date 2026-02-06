import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/auth/domain/email/usecases/check_email_use_case.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_event.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final CheckEmailUseCase checkEmailUseCase;

  EmailBloc({required this.checkEmailUseCase}) : super(EmailInitial()) {
    on<EmailSubmitted>(_onEmailSubmitted);
  }

  Future<void> _onEmailSubmitted(
    EmailSubmitted event,
    Emitter<EmailState> emit,
  ) async {
    emit(EmailLoading());

    final result = await checkEmailUseCase(event.email);

    result.fold(
      (failure) => emit(EmailFailure(failure.message)),
      (profile) => emit(EmailSuccess(profile)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/features/auth/domain/email/usecases/check_email_use_case.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_event.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final CheckEmailUseCase checkEmailUseCase;
  final AuthLocalStorage authLocalStorage;

  EmailBloc({required this.checkEmailUseCase, required this.authLocalStorage})
    : super(EmailInitial()) {
    on<EmailSubmitted>(_onEmailSubmitted);
  }

  Future<void> _onEmailSubmitted(
    EmailSubmitted event,
    Emitter<EmailState> emit,
  ) async {
    emit(EmailLoading());

    final result = await checkEmailUseCase(event.email);
    if (emit.isDone) return;
    await result.fold(
      (failure) async {
        emit(EmailFailure(failure));
      },
      (profile) async {
        await authLocalStorage.saveIdentity(profile);
        if (!emit.isDone) {
          emit(EmailSuccess(profile));
        }
      },
    );
  }
}

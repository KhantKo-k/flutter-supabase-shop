import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:shop_project/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_event.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getMyProfile;
  final UpdateProfileUseCase updateProfile;
  final AuthLocalStorage authLocalStorage;

  ProfileBloc({
    required this.getMyProfile,
    required this.updateProfile,
    required this.authLocalStorage,
  }) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfle>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final result = await getMyProfile();

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProflileLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfle event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());

    final result = await updateProfile(event.profile);

    await result.fold(
      (failure) {
        emit(ProfileError(failure.message));
      },
      (profile) async {
        final currentIdentity = authLocalStorage.getIdentity();
        if (currentIdentity != null) {
          await authLocalStorage.saveIdentity(
            currentIdentity.copyWith(username: profile.username),
          );
        }

        emit(ProflileLoaded(profile));
      },
    );
  }
}

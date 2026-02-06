
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  void call(){
    repository.logout();
  }
}
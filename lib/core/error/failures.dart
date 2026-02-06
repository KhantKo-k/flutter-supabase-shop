abstract class Failure{
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure([String? message]) : super(message ?? 'Data not found');
}

class SupabaseFailure extends Failure {
  const SupabaseFailure([String? message]) : super(message ?? 'Supabase operation failed');
}
class FailureMessages {
  static const invalidCredentials = 'Invalid email or password';
  static const userAlreadyExists = 'User already exists';
  static const networkError = 'Please check your internet connection';
  static const unexpectedError = 'Something went wrong. Please try again';
}
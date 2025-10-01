import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;
  SignIn(this.repository);

  Future<User?> call(String email, String password) {
    return repository.signInWithEmail(email, password);
  }
}

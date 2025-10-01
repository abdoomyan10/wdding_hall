import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User?> signInWithEmail(String email, String password) {
    return dataSource.signInWithEmail(email, password);
  }

  @override
  Future<User?> signUpWithEmail(String email, String password, {String? name}) {
    return dataSource.signUpWithEmail(email, password, name: name);
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  @override
  Future<User?> getCurrentUser() {
    return dataSource.getCurrentUser();
  }
}

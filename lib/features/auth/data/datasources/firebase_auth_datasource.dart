import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/entities/user.dart';

class FirebaseAuthDataSource {
  final fb.FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource({fb.FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser = result.user;
    if (fbUser == null) return null;
    return User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      name: fbUser.displayName,
    );
  }

  Future<User?> signUpWithEmail(
    String email,
    String password, {
    String? name,
  }) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser = result.user;
    if (fbUser == null) return null;
    if (name != null) await fbUser.updateDisplayName(name);
    return User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      name: name ?? fbUser.displayName,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    final fbUser = _firebaseAuth.currentUser;
    if (fbUser == null) return null;
    return User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      name: fbUser.displayName,
    );
  }
}

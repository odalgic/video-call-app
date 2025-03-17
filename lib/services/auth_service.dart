import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to authentication state changes
  Stream<User?> get userStream => _auth.authStateChanges();

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Error signing in: $e');
      rethrow; // Re-throw the error to handle it in the UI
    }
  }

  // Sign up with email and password
  Future<void> signUp(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  } catch (e) {
    print('Full error: $e'); // Print the full error object

    if (e is FirebaseAuthException) {
      print('Error code: ${e.code}'); // Print the error code
      print('Error message: ${e.message}'); // Print the error message
    } else {
      print('Non-Firebase error: $e'); // Handle non-Firebase errors
    }

    rethrow; // Re-throw the error to handle it in the UI
  }
}

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow; // Re-throw the error to handle it in the UI
    }
  }
}
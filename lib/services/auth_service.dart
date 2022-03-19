import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth? _auth;
  static final AuthenticationService _authInstance =
      AuthenticationService._init();

  AuthenticationService._init();

  static AuthenticationService get instance {
    return _authInstance;
  }

  static authInit() {
    _authInstance._auth ??= FirebaseAuth.instance;
    return;
  }

  Future<void> signOut() async {
    await _auth?.signOut();
  }

  Future<void> signInWithMail(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //TODO
      } else if (e.code == 'email-already-in-use') {
        //TODO
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<void> login(String email, String password) async {
  //   await _auth?.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }
}

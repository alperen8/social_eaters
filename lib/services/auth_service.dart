import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_eaters/config/constanst.dart';

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

  recordUser(String? name, String? surname, String? mail, String firebaseId) {
    Map<String, dynamic> data = {
      "objects": {
        "name": name,
        "surname": surname,
        "mail": mail,
        "firebaseId": firebaseId,
      }
    };
    try {
      Dio().post(AppConstants.apiUrl + "/createUser", data: data);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> loginWithMail(String email, String password) async {
    bool isLoggedIn = false;
    try {
      UserCredential userCredential = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user?.uid != null) {
        isLoggedIn = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return isLoggedIn;
  }

  Future<bool> signInWithMail(
      String? name, String? surname, String email, String password) async {
    bool isSignedIn = false;
    try {
      UserCredential userCredential =
          await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      recordUser(
          name, surname, userCredential.user?.email, userCredential.user!.uid);

      if (userCredential.user?.uid != null) {
        isSignedIn = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //TODO
      } else if (e.code == 'email-already-in-use') {
        //TODO
      }
    } catch (e) {
      print(e);
    }
    return isSignedIn;
  }

  // Future<void> login(String email, String password) async {
  //   await _auth?.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }
}

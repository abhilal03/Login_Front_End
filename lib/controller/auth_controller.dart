
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

// enum AuthStatus {
//   successful,
//   wrongPassword,
//   emailAlreadyExists,
//   invalidEmail,
//   weakPassword,
//   unknown,
// }

class AuthController {
  // AuthController(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser; //(){ return fir..}

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signInWithEmailAndPassword({
    String email = '',
    String password = '',
  }) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //_user.user.displayName;
      return 'ok';
    } on FirebaseAuthException catch (e) {
      // invalid-email:
      // user-disabled:
      // user-not-found:
      // wrong-password:
      // CustomAlerts.errorMessage(
      //     message: AuthExceptionHandler.handleAuthException(e),
      //     context: context,
      //     showAction: false,
      //     label: '',
      //     action: (){});
      
        // if (e.code == 'user-not-found') {
        //   print('User not found');
        // } else if (e.code == 'wrong-password') {
        //   print('Wrong password');
        // } else {
        //   print('Firebase Error: ${e.message}');
        // }
      
      return 'e.code';
    } catch (e) {
      return 'error';
    }
  }

  Future<String> createUserWithEmailAndPasswords({
    String email = '',
    String password = '',
  }) async {
    try {
    
      UserCredential users = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //users.user!.sendEmailVerification();
      //_user.user.uid
      //_user.user.displayName;
      return 'ok';
    } on FirebaseAuthException catch (e) {
      //email-already-in-use:
      //invalid-email:
      //weak-password:
      return 'e.code';
    } catch (e) {
      return 'error';
    }
  }

  Future resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Failed to send password reset email: $e');
    }
  }
  // Future<void> senDEmailVerificaton() async{
  //   try {
  //      await _firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings)
  //   } catch (e) {

  //   }
  // }

  Future<void> signOut() async => await _firebaseAuth.signOut();

  changePassword(String newpass) async {
    User? user = _firebaseAuth.currentUser;

    if (user == null) return 'user not found';

    AuthCredential credential = EmailAuthProvider.credential(
        email: user.email ?? '', password: newpass);

    await user.reauthenticateWithCredential(credential);
    //user.reauthenticate(credential)
  }

  //static Future<User?> signInWithGoogle({required BuildContext context}) async {
  //  FirebaseAuth auth = FirebaseAuth.instance;
  //  User? user;

  //  final GoogleSignIn googleSignIn = GoogleSignIn();

  //  final GoogleSignInAccount? googleSignInAccount =
  //      await googleSignIn.signIn();

  //  if (googleSignInAccount != null) {
  //    final GoogleSignInAuthentication googleSignInAuthentication =
  //        await googleSignInAccount.authentication;

  //    final AuthCredential credential = GoogleAuthProvider.credential(
  //      accessToken: googleSignInAuthentication.accessToken,
  //      idToken: googleSignInAuthentication.idToken,
  //    );

  //    try {
  //      final UserCredential userCredential =
  //          await auth.signInWithCredential(credential);

  //      user = userCredential.user;
  //    } on FirebaseAuthException catch (e) {
  //      if (e.code == 'account-exists-with-different-credential') {
  //        // handle the error here
  //      }
  //      else if (e.code == 'invalid-credential') {
  //        // handle the error here
  //      }
  //    } catch (e) {
  //      // handle the error here
  //    }
  //  }

  //  return user;
  //}
}

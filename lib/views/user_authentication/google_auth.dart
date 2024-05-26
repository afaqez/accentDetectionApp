import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:accent_detection_app/views/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return null;
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _signOut(); // Sign out before signing in
        User? user = await _signInWithGoogle(context);
        if (user != null) {
          // Navigate to the home screen after successful sign-in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          // Handle sign-in failure
          print('Failed to sign in with Google.');
        }
      },
      child: Text('Sign in with Google'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginApi {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in: $error');
      return null;
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyTestApp());
}

class MyTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Sign-In Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              var user = await LoginApi.login();
              if (user != null) {
                print('oke nih');
                print(user.displayName);
                print(user.email);
              } else {
                print('User cancelled the sign in');
              }
            },
            child: Text('Sign in with Google'),
          ),
        ),
      ),
    );
  }
}

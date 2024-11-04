import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class LoginApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future signOut = _googleSignIn.signOut();
}

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String responseMessage = ''; // Removed final to make it mutable
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> sendEmail(String email, String password) async {
    final url =
        Uri.parse('http://10.2.5.204:5000/login'); // Replace with your API URL
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    setState(() {
      if (response.statusCode == 200) {
        responseMessage =
            '${jsonDecode(response.body)['email'] + '\n' + jsonDecode(response.body)['password']}';
      } else {
        responseMessage = 'Error: ${response.statusCode}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ), // Здесь укажите иконку
          onPressed: () {
            // Действие при нажатии на иконку
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ]),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'aisultan@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 2,
                        style: BorderStyle.none,
                      ),
                    ),
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    filled: true,
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 54, 52, 52)),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 26, 25,
                              25)), // Цвет рамки, когда поле активно
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.white), // Цвет рамки, когда поле в фокусе
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ]),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 2,
                        style: BorderStyle.none,
                      ),
                    ),
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    filled: true,
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 54, 52, 52)),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 26, 25,
                              25)), // Цвет рамки, когда поле активно
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.white), // Цвет рамки, когда поле в фокусе
                    ),
                  ),
                  obscureText: true,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Forgot password? ',
                          style: TextStyle(color: Colors.yellowAccent),
                        ))
                  ],
                ),
                Container(
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                    ),
                    onPressed: () {
                      // Логика для аутентификации
                      final email = emailController.text;
                      final password = passwordController.text;
                      print('Email: $email, Password: $password');
                      sendEmail(email, password); // Call the sendEmail function
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Color of the divider
                          thickness: 1, // Thickness of the divider line
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Space around the text
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white), // Text style
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Color of the divider
                          thickness: 1, // Thickness of the divider line
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      side: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 26, 25, 25)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                    ),
                    onPressed: () async {
                      var user = await LoginApi.login();
                      if (user != null) {
                        print('oke nih');
                        print(user.displayName);
                        print(user.email);
                      }
                    },
                    child: Row(children: [
                      SvgPicture.asset(
                        'lib/assets/icons-google.svg',
                        width: 30, // Set the width if needed
                        height: 30, // Set the height if needed
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )
                    ])),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    responseMessage, // Display the response message
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 50),
          alignment: Alignment.center,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      color: const Color.fromARGB(255, 117, 111, 111)),
                  children: [
                    TextSpan(
                        text:
                            'CarApp uses cookies for analytics personallized content and ads. By using CarApp`s services you agree to this use of cookies'),
                    TextSpan(
                        text: ' Learn more', // Link text
                        style: TextStyle(
                            color: Colors.blue,
                            decoration:
                                TextDecoration.underline), // Style for the link
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Action when "Learn more" is tapped
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('User Agreement'),
                                  content:
                                      Text('Display your user agreement here.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          })
                  ]))),
    );
  }
}

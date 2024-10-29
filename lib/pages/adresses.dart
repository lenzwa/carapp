import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AdressesPage extends StatelessWidget {
  AdressesPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String hrefTo) async {
      final Uri url = Uri.parse(hrefTo);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Addresses',
          style: TextStyle(color: Colors.white),
        ),
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12),
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.house_sharp,
                      size: 36,
                      color: Colors.white,
                    ),
                    Text(
                      'InterTeach Nazarbayeva',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(
                  'InterTeach Nazarbayeva head office of department in medical insurancy',
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchUrl('https://go.2gis.com/fk7v9');
                              },
                            text: 'View on map',
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(255, 30, 136, 223))))
                  ],
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}

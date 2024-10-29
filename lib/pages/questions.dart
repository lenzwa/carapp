import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionsPage extends StatelessWidget {
  QuestionsPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _launchUrl(String hrefTo) async {
    final Uri url = Uri.parse(hrefTo);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'dvaklon82@gmail.com', // Replace with recipient's email
      query: Uri.encodeFull(
          'subject=Your Subject Here&body=Email body goes here'), // Optional
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      print('Could not launch $emailLaunchUri: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'FAQ and Support',
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 12, 12, 12)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          softWrap: true,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Didn`t find the answers you are looking for?\n'),
                            TextSpan(text: 'Contact our support team!')
                          ])),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 54, 52, 52),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                              ),
                              onPressed: () {
                                _launchUrl('https://interteach.kz');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.web_asset,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Go to our website',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 54, 52, 52),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                              ),
                              onPressed: () {
                                _launchEmail();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.alternate_email,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Send us an email',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 54, 52, 52),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                              ),
                              onPressed: () {
                                _makePhoneCall('+77009566692');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Phone us',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 52, 52),
                    borderRadius: BorderRadius.circular(10)),
                child: ExpandablePanel(
                  collapsed: Text(
                    style: TextStyle(color: Colors.white),
                    'To reset your password, please enter your registered ...',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    style: TextStyle(color: Colors.white),
                    'To reset your password, please enter your registered email address below. We’ll send you a link to create a new password. Check your email inbox and follow the link to complete the reset process. If you don’t receive an email, please check your spam folder or try again.',
                    softWrap: true,
                  ),
                  header: Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How do i change my password',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 52, 52),
                    borderRadius: BorderRadius.circular(10)),
                child: ExpandablePanel(
                  collapsed: Text(
                    style: TextStyle(color: Colors.white),
                    'To check your car`s status, please go to the My Car  ...',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    style: TextStyle(color: Colors.white),
                    'To check your car’s status, please go to the My Car section in the app. Here, you’ll find detailed information about maintenance, diagnostics, and any active alerts.',
                    softWrap: true,
                  ),
                  header: Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How do I check my car?',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 52, 52),
                    borderRadius: BorderRadius.circular(10)),
                child: ExpandablePanel(
                  collapsed: Text(
                    style: TextStyle(color: Colors.white),
                    'We are located in Almaty. Please visit us at our office ...',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    style: TextStyle(color: Colors.white),
                    'We are located in Almaty. Please visit us at our office. For exact directions, refer to the Contact Us section in the app or use the map feature to navigate.',
                    softWrap: true,
                  ),
                  header: Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Where are we?',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 52, 52),
                    borderRadius: BorderRadius.circular(10)),
                child: ExpandablePanel(
                  collapsed: Text(
                    style: TextStyle(color: Colors.white),
                    'Our bonus system provides you with a 10% bonus ...',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    style: TextStyle(color: Colors.white),
                    'Our bonus system provides you with a 10% bonus on eligible purchases. For every transaction, you earn points which can be redeemed later for discounts and special offers. Check your bonus points balance in the app under the Rewards section.',
                    softWrap: true,
                  ),
                  header: Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Bonus system 10% - what does that mean?',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              )),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

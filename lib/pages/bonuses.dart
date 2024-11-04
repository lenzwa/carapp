import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class BonusesPage extends StatelessWidget {
  BonusesPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Bonuses',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ListView(
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Open bonus system 5-20%\n',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              TextSpan(
                  style: TextStyle(fontSize: 15),
                  text:
                      'Lorem lorem lorem lorem Lorem lorem lorem lorem Lorem lorem lorem lorem Lorem lorem lorem lorem Lorem lorem lorem lorem Lorem lorem lorem lorem ')
            ])),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Your payments',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: ':Payment amount:\n'),
                          TextSpan(text: ':Payment data:')
                        ])),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor:
                                    const Color.fromARGB(0, 102, 255, 0),
                                shadowColor: Colors.transparent,
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 26, 25, 25)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onPressed: () {},
                            child: Text(
                              'Payment details',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 14, 185, 42)),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: ':Payment amount:\n'),
                          TextSpan(text: ':Payment data:')
                        ])),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor:
                                    const Color.fromARGB(0, 102, 255, 0),
                                shadowColor: Colors.transparent,
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 26, 25, 25)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onPressed: () {},
                            child: Text(
                              'Payment details',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 14, 185, 42)),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    height: 100,
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: ':Payment amount:\n'),
                          TextSpan(text: ':Payment data:')
                        ])),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor:
                                    const Color.fromARGB(0, 102, 255, 0),
                                shadowColor: Colors.transparent,
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 26, 25, 25)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onPressed: () {},
                            child: Text(
                              'Payment details',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 14, 185, 42)),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    height: 100,
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: ':Payment amount:\n'),
                          TextSpan(text: ':Payment data:')
                        ])),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor:
                                    const Color.fromARGB(0, 102, 255, 0),
                                shadowColor: Colors.transparent,
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 26, 25, 25)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onPressed: () {},
                            child: Text(
                              'Payment details',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 14, 185, 42)),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

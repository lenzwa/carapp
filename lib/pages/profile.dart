import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
              size: 20,
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
        bottomNavigationBar: Container(
            height: 100,
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Убираем цвет фона
                  foregroundColor: Colors.black, // Цвет текста
                  shadowColor: Colors.transparent, // Убираем тень
                  elevation: 0, // Убираем Elevation
                  overlayColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                ),
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ))),
        body: ListView(
          children: [
            Container(
              height: 200,
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                          ),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                TextSpan(text: 'Aisultan '),
                                TextSpan(text: 'Aidosov')
                              ])),
                        ],
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 54, 52, 52)),
                  child: Column(
                    children: [
                      Icon(
                        Icons.analytics,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Analytics',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 54, 52, 52)),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Add car',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 54, 52, 52)),
                  child: Column(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text('Your cars: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 90,
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(
                                8.0), // Внутренние отступы со всех сторон
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 93, 98, 102), // Цвет фона
                              borderRadius: BorderRadius.circular(
                                  16), // Радиус для скругления углов
                            ),
                            child: Text(
                              'Mercedes',
                              style: TextStyle(
                                color: const Color.fromARGB(
                                    255, 247, 233, 233), // Цвет текста
                                fontSize: 12, // Размер шрифта
                              ),
                            ),
                          )
                        ],
                      ),
                      Image.asset(
                        'lib/assets/mercedes.png',
                        width: 350,
                        height: 150, // Высота изображения
                        fit: BoxFit.cover, // Настройка подгонки изображения
                      ),
                      Divider(
                        color: const Color.fromARGB(255, 59, 58, 58),
                        thickness: 2,
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Mercedes E-200 2020(American)',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          )
                        ], // Отступ между изображением и текстом
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'PKR Locs',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: const Color.fromARGB(255, 201, 182, 11),
                                size: 24,
                              ),
                              Text(
                                '4.4',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(padding: EdgeInsets.all(5))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 48, 44, 44)),
                )
              ],
            )
          ],
        ));
  }
}

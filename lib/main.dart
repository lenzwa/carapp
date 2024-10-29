import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/bonuses.dart';
import 'package:flutter_application_1/pages/contacts.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/signin.dart';
import 'package:flutter_application_1/pages/adresses.dart';
import 'package:flutter_application_1/pages/questions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

// Create an InheritedWidget for state management
class ResponseState extends InheritedWidget {
  final String responseMessage;
  final Function(String) updateResponseMessage;

  const ResponseState({
    super.key,
    required this.responseMessage,
    required this.updateResponseMessage,
    required super.child,
  });

  static ResponseState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponseState>();
  }

  @override
  bool updateShouldNotify(ResponseState oldWidget) {
    return oldWidget.responseMessage != responseMessage;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController myController = TextEditingController();
  String responseMessage = '';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<void> getVinNumbers(String vinnumber) async {
    final url = Uri.parse(
        'http://192.168.88.1:5000/api/vin'); // Replace with your API URL
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    responseMessage = '$response';
  }

  Future<void> sendVinNumber(String vin) async {
    final url = Uri.parse(
        'http://10.2.5.204:5000/api/vin'); // Replace with your API URL
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'vin': vin,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        responseMessage = 'Success: ${response.body}';
      });
    } else {
      setState(() {
        responseMessage = 'Error: ${response.statusCode}';
      });
    }
  }

  void _onSubmit() {
    if (myController.text.isNotEmpty) {
      sendVinNumber(myController.text);
    } else {
      setState(() {
        responseMessage = 'Please enter a VIN number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Outfit',
      ),
      home: ResponseState(
        responseMessage: responseMessage,
        updateResponseMessage: (newMessage) {
          setState(() {
            responseMessage = newMessage;
          });
        },
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Car App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Builder(
              builder: (context) => ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Colors.transparent), // Прозрачный фон
                    elevation: WidgetStateProperty.all(0), // Убирает тень

                    minimumSize: WidgetStateProperty.all(
                        Size.zero), // Убирает минимальный размер
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Сокращает область клика
                    shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.zero, // Убирает закругления углов
                      side: BorderSide.none, // Убирает бордер
                    )),
                    overlayColor: WidgetStateProperty.all(
                        Colors.transparent), // Убирает цвет при нажатии
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(
                    color: Colors.black,
                    Icons.menu,
                    size: 28,
                  )))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const ListOfItems(), const Footer()],
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Car app',
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 32),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 75, 75, 75),
              ),
            ),
            ListTile(
              title: Text(
                'Профиль',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: Text(
                'Вопросы',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionsPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: Text(
                'Адреса сервиса',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdressesPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: Text(
                'Контакты',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: Text(
                'Бонусы',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BonusesPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final responseState = ResponseState.of(context);
    final TextEditingController myController = TextEditingController();

    Future<void> sendVinNumber(String vin) async {
      final url = Uri.parse(
          'http://10.2.5.204:5000/api/vin'); // Replace with your API URL
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'vin': vin,
        }),
      );

      if (response.statusCode == 200) {
        responseState
            ?.updateResponseMessage(jsonDecode(response.body)['message']);
      } else {
        responseState?.updateResponseMessage('Error: ${response.statusCode}');
      }
    }

    void _onSubmit() {
      if (myController.text.isNotEmpty) {
        sendVinNumber(myController.text);
      } else {
        responseState?.updateResponseMessage('Please enter a VIN number');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              _onSubmit();
            },
            controller: myController,
            decoration: InputDecoration(
              hintText: 'Search VIN Number',
              hintStyle: const TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.only(left: 30),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 24.0, left: 16.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.home,
            size: 24,
            color: Colors.black,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            ),
            onPressed: () {
              // Используем Navigator для перехода к новому экрану с QrCodeScanner
            },
            child: Icon(
              Icons.qr_code_2_sharp,
              size: 24,
              color: Colors.black,
            ),
          ),
          const Icon(
            Icons.card_membership,
            size: 24,
            color: Colors.black,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: const Icon(
                Icons.person,
                size: 24,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}

class ListOfItems extends StatelessWidget {
  const ListOfItems({super.key});

  @override
  Widget build(BuildContext context) {
    final responseState = ResponseState.of(context); // Get the response state

    return Expanded(
      child: ListView(
        children: [
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(padding: EdgeInsets.only(top: 100, bottom: 100)),
              Text('Welcome Home',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
            ]),
          ),
          const SearchWidget(),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 25,
              separatorBuilder: (BuildContext context, int index) =>
                  const VerticalDivider(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 200,
                  child: Center(
                    child: Text(
                      'item $index',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              responseState?.responseMessage ??
                  '', // Display the response message
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Container(
            height: 140,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        '10.00%',
                        style: TextStyle(fontSize: 28),
                      ),
                      Spacer(),
                      Text(
                        'Бонусная система в 10% ! ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_sharp,
                        size: 24,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              16), // Removes the default rounded corners
                        ),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BonusesPage()),
                        );
                      },
                      child: Text(
                        'Перейти к системе',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 193, 224, 14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Цвет тени с прозрачностью
                    spreadRadius: 2, // Насколько распространяется тень
                    blurRadius: 5, // Размытие тени
                    offset: Offset(0, 3), // Смещение тени (по оси X и Y)
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 25)),
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            margin: EdgeInsets.symmetric(horizontal: 15),
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
                        color:
                            const Color.fromARGB(255, 93, 98, 102), // Цвет фона
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
                              color: Colors.white, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

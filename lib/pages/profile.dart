import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text here'),
        leading: Builder(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Colors.black,
                ))),
      ),
      body: Text('data'),
    );
  }
}

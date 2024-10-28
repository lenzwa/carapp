import 'package:flutter/material.dart';

class AdressesPage extends StatelessWidget {
  AdressesPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text here'),
      ),
      body: Text('data'),
    );
  }
}

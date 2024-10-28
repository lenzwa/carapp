import 'package:flutter/material.dart';

class QuestionsPage extends StatelessWidget {
  QuestionsPage({super.key});

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

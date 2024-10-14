import 'package:flutter/material.dart';
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
    Key? key,
    required this.responseMessage,
    required this.updateResponseMessage,
    required Widget child,
  }) : super(key: key, child: child);

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

  Future<void> sendVinNumber(String vin) async {
    final url = Uri.parse(
        'https://your-api-url.com/endpoint'); // Replace with your API URL
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Car App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [SearchWidget(), ListOfItems(), Footer()],
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
          'https://your-api-url.com/endpoint'); // Replace with your API URL
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
        responseState?.updateResponseMessage('Success: ${response.body}');
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
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Submit'),
          ),
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
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.home,
            size: 24,
            color: Colors.black,
          ),
          Icon(
            Icons.card_membership,
            size: 24,
            color: Colors.black,
          ),
          Icon(
            Icons.person,
            size: 24,
            color: Colors.black,
          ),
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
          Text(
            responseState?.responseMessage ??
                '', // Display the response message
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

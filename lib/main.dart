import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/signin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class QrCodeScanner extends StatelessWidget {
  QrCodeScanner({super.key});

  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) {
        final List<Barcode> barcodes = capture.barcodes;

        for (final barcode in barcodes) {
          print(barcode.rawValue);
        }
      },
    );
  }
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
    responseMessage = '${response}';
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
      padding: const EdgeInsets.only(top: 20, bottom: 20),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QrCodeScanner()),
              );
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
        ],
      ),
    );
  }
}

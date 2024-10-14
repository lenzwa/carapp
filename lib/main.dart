import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Outfit'
          // Задает основную цветовую тему приложения
          ),
      home: const MyHomePage(),
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
            )
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
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
                  contentPadding: const EdgeInsets.only(
                    left: 30,
                  ),
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
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 200, // Set a fixed height for the ListView
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 25,
                    separatorBuilder: (BuildContext context, int index) =>
                        const VerticalDivider(),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 200, // Set width for each item
                        child: Center(
                          child: Text('item $index'),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 200,
                  decoration: const BoxDecoration(color: Colors.orange),
                ),
                Container(
                    height: 200,
                    decoration: const BoxDecoration(color: Colors.red)),
                Container(
                    height: 200,
                    decoration: const BoxDecoration(color: Colors.blue)),
              ],
            ),
          ),
          Container(
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
                )
              ],
            ),
          )
        ]));
  }
}

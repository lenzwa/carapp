import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Outfit'
          // Задает основную цветовую тему приложения
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Car App",
          ),
          centerTitle: false,
          actions: [
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
            padding: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search VIN Number',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(
                    left: 30,
                  ),
                  suffixIcon: Padding(
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
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 25,
              separatorBuilder: (BuildContext context, int index) =>
                  const VerticalDivider(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150,

                  width: 100, // Задаем ширину для каждого элемента
                  child: Center(
                    child: Text('item $index'),
                  ),
                );
              },
            ),
          ),
          Container(
              child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Container(
                    child: Icon(
                      Icons.home,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    child: Icon(
                      Icons.card_membership,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    child: Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ))
        ]));
  }
}

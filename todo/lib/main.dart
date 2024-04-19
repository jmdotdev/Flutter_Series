import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App", style: TextStyle(fontSize: 25)),
        elevation: 8,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.purple[900],
                  child: const Text("Container A"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  color: Colors.purple[900],
                  child: const Text("Container B"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  color: Colors.purple[900],
                  child: const Text("Container C"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  color: Colors.purple[900],
                  child: const Text("Container D"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

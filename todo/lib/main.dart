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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  List<String> _tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App", style: TextStyle(fontSize: 25)),
        elevation: 8,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(helperText: "Enter Todo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Add A Task";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _tasks.add(_titleController.text);
                      _titleController.clear();
                    });
                  },
                  child: const Text("Add Todo")),
              Expanded(
                  child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Text(_tasks[index]),
                        );
                      })),
            ],
          )),
    );
  }
}

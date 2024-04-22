import 'package:flutter/material.dart';
import 'package:todo/Models/todo.dart';

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
  final TextEditingController __descriptionController = TextEditingController();
  final List<Todo> _tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App", style: TextStyle(fontSize: 25)),
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      hintText: "Enter Todo Title",
                      hintStyle: TextStyle(fontSize: 12)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Add A Title";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Enter Todo Description",
                      hintStyle: TextStyle(fontSize: 12)),
                  controller: __descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Add A Description";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          var todo = Todo(
                              Id: _tasks.length + 1,
                              Title: _titleController.text,
                              Description: __descriptionController.text,
                              IsComplete: false);
                          _tasks.add(todo);
                          _titleController.clear();
                          __descriptionController.clear();
                        }
                      });
                    },
                    child: const Text("Add Todo")),
                Expanded(
                    child: ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              leading: Text(_tasks[index].Id.toString()),
                              title: Text(_tasks[index].Title),
                              subtitle: Text(_tasks[index].Description),
                              trailing: Text(_tasks[index].IsComplete
                                  ? "Complete"
                                  : "Not Complete"),
                            ),
                          );
                        })),
              ],
            )),
      ),
    );
  }
}

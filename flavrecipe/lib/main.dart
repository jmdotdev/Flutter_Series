import 'dart:convert';

import 'package:flavrecipe/Models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FavRecipe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Recipe>> _recipe;

  Future<List<Recipe>> getRecipes() async {
    var response = await http.get(Uri.parse(
        "https://api.edamam.com/api/recipes/v2?type=public&q=banana&app_id=db2d13b4&app_key=5e484bb46580cf5555266d661316b3f6"));
    if (response.statusCode == 200) {
      List<dynamic> hits = jsonDecode(response.body)['hits'];
      List<Recipe> recipes =
          hits.map((hit) => Recipe.fromJson(hit['recipe'])).toList();
      return recipes;
    }
    throw const FormatException('failed to load recipes1');
  }

  @override
  void initState() {
    super.initState();
    _recipe = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Recipe>>(
          future: _recipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(snapshot.data![index].label),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

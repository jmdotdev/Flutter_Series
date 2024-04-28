import 'dart:convert';

import 'package:flavrecipe/Models/recipe.dart';
import 'package:flavrecipe/Screens/recipe_detail.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FlavRecipe'),
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
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Recipe>>(
          future: _recipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  snapshot.data![index].image,
                                ),
                                radius: 60,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              snapshot.data![index].label,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RecipeDetail(
                                  label: snapshot.data![index].label,
                                  image: snapshot.data![index].image,
                                  source: snapshot.data![index].source)));
                        },
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error Fetching Recipes"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

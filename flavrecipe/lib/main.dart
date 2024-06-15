import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
      builder: EasyLoading.init(),
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
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  String query = "beef";
  bool loading = false;
  int _selectedIndex = 0;
  Future<List<Recipe>> getRecipes(query) async {
    var response = await http.get(Uri.parse(
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=db2d13b4&app_key=5e484bb46580cf5555266d661316b3f6"));
    if (response.statusCode == 200) {
      List<dynamic> hits = jsonDecode(response.body)['hits'];
      List<Recipe> recipes =
          hits.map((hit) => Recipe.fromJson(hit['recipe'])).toList();
      return recipes;
    }
    throw const FormatException('failed to load recipes');
  }

  void setActiveIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _recipe = getRecipes(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      bottomNavigationBar:
        BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: "Favourite"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 1, 36, 65),
      onTap: setActiveIndex,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What Will You Cook Today?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Just type in a keyword and we will provide you with the recipe and ingredients needed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                  hintText: "type your keyword.eg.(banana)"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Add A Description";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      loading = true;
                                      query = searchController.text;
                                      _recipe = getRecipes(query);
                                      searchController.clear();
                                    }
                                  });
                                },
                                child: const Icon(Icons.search))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Recipe>>(
                future: _recipe,
                builder: (context, snapshot) {
                  if (loading) {
                    EasyLoading.showToast('loading $query recipes...',
                        maskType: EasyLoadingMaskType.black);
                  }
                  if (snapshot.hasData) {
                    loading = false;
                    return GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            snapshot.data![index].image,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5.5,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![index].label,
                                          textAlign: TextAlign.left,
                                          // softWrap: true,
                                          // maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RecipeDetail(
                                      label: snapshot.data![index].label,
                                      image: snapshot.data![index].image,
                                      source: snapshot.data![index].source,
                                      totalTime:
                                          snapshot.data![index].totalTime,
                                      yield: snapshot.data![index].yield,
                                      ingredientLines: snapshot
                                          .data![index].ingredientLines)));
                            },
                          );
                        });
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error fetching recipes"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

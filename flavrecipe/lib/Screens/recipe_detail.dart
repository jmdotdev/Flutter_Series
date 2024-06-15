import 'dart:ffi';

import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({
    super.key,
    required this.label,
    required this.image,
    required this.source,
    required this.totalTime,
    required this.yield,
    required this.ingredientLines,
  });

  final String label;
  final String image;
  final String source;
  final double totalTime;
  final double yield;
  final List<String> ingredientLines;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _selectedIndex = 0;

  void setActiveIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(label),
      //   centerTitle: true,
      // ),
      bottomNavigationBar: BottomNavigationBar(
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
      body: ListView(
        children: [
          // Product image
          Image.network(
            widget.image,
            height: MediaQuery.of(context).size.height / 2.5,
            fit: BoxFit.fill,
          ),
          //Recipe Title
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25),
                    )
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.watch_later_rounded,
                          color: Colors.green,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${(widget.totalTime ~/ 60)}" + "hrs")
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.green,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${(widget.yield)}")
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ingredients",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                ...widget.ingredientLines.map((e) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(
                        Icons.food_bank,
                        color: Colors.green,
                      ),
                      title: Text(e),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

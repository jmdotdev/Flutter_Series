import 'dart:ffi';

import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(label),
      //   centerTitle: true,
      // ),
      body: ListView(
        children: [
          // Product image
          Image.network(
            image,
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
                      label,
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
                        Text("${(totalTime ~/ 60)}" + "hrs")
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
                        Text("${(yield)}")
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
                ...ingredientLines.map((e) => ListTile(
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

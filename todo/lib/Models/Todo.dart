// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class Todo {
  int Id;
  String Title;
  String Description;
  bool IsComplete;

  Todo(
      {required this.Id,
      required this.Title,
      required this.Description,
      required this.IsComplete});
}

import 'package:flutter/material.dart';
import 'package:expenses_app/expenses_app.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const ExpensesApp(),
    ),
  );
}

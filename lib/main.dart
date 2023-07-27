import 'package:flutter/material.dart';
import 'package:expenses_app/expenses_app.dart';

ColorScheme lightColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 91, 165));

ColorScheme darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 10, 36, 65),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: darkColorScheme.secondary,
          foregroundColor: darkColorScheme.onSecondary,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const ExpensesApp(),
    ),
  );
}

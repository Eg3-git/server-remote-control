import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme(var context) {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, background: Colors.black),
  appBarTheme: AppBarTheme(
  backgroundColor: Colors.deepPurple,
  titleTextStyle: Theme.of(context).textTheme.apply(
  bodyColor: Colors.white,
  displayColor: const Color(0xff22215B),
  ).titleLarge,
  ),
  textTheme: Theme.of(context).textTheme.apply(
  bodyColor: Colors.white,
  displayColor: Colors.white,
  ),
    useMaterial3: true,);
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheel_strategy/pages/home.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}

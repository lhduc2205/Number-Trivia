import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/number_trivia_app.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  await di.configureDependencies();

  runApp(const NumberTriviaApp());
}

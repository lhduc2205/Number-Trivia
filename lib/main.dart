import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/number_trivia_app.dart';

import 'injection_container.dart';

Future<void> main() async {
  await configureDependencies();

  runApp(const NumberTriviaApp());
}

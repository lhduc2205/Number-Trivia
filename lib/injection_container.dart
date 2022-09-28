import 'package:get_it/get_it.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(concrete: sl(), random: sl(), inputConverter: sl()),
  );

  //! Core

  //! External
}

void _initFeature() {}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_trivia/core/contants/contants.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required InputConverter inputConverter,
  })  : _getConcreteNumberTrivia = concrete,
        _getRandomNumberTrivia = random,
        _inputConverter = inputConverter,
        super(Empty()) {
    on<GetTriviaForConcreteNumber>(
        (event, emit) => _onGetConcreteNumberTrivia(event, emit));

    on<GetTriviaForRandomNumber>(
        (event, emit) => _onGetTriviaForRandomNumber(event, emit));
  }

  _onGetConcreteNumberTrivia(
    GetTriviaForConcreteNumber event,
    Emitter emitter,
  ) {
    final inputEither =
        _inputConverter.stringToUnsignedInteger(event.numberString);
    inputEither.fold(
      (failure) => emitter(Error(message: INVALUD_INPUT_FAILURE_MESSAGE)),
      (integer) => emitter(Loading()),
    );
  }

  _onGetTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter emitter,
  ) {}
}

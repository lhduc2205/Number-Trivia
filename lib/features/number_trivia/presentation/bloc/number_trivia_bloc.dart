import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_trivia/core/contants/contants.dart';
import 'package:number_trivia/core/error/failures.dart';
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
    on<GetTriviaForConcreteNumber>(_onGetConcreteNumberTrivia);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  Future<void> _onGetConcreteNumberTrivia(
    GetTriviaForConcreteNumber event,
    Emitter emit,
  ) async {
    final inputEither = _inputConverter.stringToUnsignedInteger(
      event.numberString,
    );
    inputEither.fold(
      (failure) => emit(Error(message: INVALUD_INPUT_FAILURE_MESSAGE)),
      (integer) async {
        emit(Loading());
        final failureOrTrivia = await _getConcreteNumberTrivia(
          Param(number: integer),
        );
        _eitherLoadedOrErrorState(emit, failureOrTrivia);
      },
    );
  }

  Future<void> _onGetTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter emit,
  ) async {
    emit(Loading());
    final failureOrTrivia = await _getRandomNumberTrivia(const NoParam());
    _eitherLoadedOrErrorState(emit, failureOrTrivia);
  }

  void _eitherLoadedOrErrorState(
    Emitter emit,
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) {
    emit(
      failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trivia) => Loaded(trivia: trivia),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

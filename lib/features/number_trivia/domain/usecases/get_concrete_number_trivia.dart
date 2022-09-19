import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Param> {
  final NumberTriviaRepository _numberTriviaRepository;

  const GetConcreteNumberTrivia(NumberTriviaRepository numberTriviaRepository)
      : _numberTriviaRepository = numberTriviaRepository;

  @override
  Future<Either<Failure, NumberTrivia?>?> call(Param param) async {
    return await _numberTriviaRepository.getConcreteNumberTrivia(param.number);
  }
}

class Param extends Equatable {
  final int number;

  const Param({required this.number});

  @override
  List<Object?> get props => [number];
}
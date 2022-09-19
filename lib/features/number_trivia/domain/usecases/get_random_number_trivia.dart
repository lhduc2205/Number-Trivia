import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParam> {
  final NumberTriviaRepository _repository;

  const GetRandomNumberTrivia(NumberTriviaRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, NumberTrivia?>?> call(NoParam _) async {
    return await _repository.getRandomNumberTrivia();
  }
}

class NoParam extends Equatable {
  const NoParam();

  @override
  List<Object?> get props => [];
}

import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository _numberTriviaRepository;

  const GetConcreteNumberTrivia(NumberTriviaRepository numberTriviaRepository)
      : _numberTriviaRepository = numberTriviaRepository;

  Future<Either<Failure, NumberTrivia>?> execute({required int? number}) async {
    return await _numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}

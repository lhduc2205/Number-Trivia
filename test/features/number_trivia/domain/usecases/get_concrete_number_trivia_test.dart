import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  final mockNumberTriviaRepository = MockNumberTriviaRepository();
  final useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: 2);

  test(
    'should get trivia for number from the repository',
    () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      final result = await useCase.execute(number: tNumber);
      print(result);
      print(const Right(tNumberTrivia));

      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/contants/contants.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  final mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
  final mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
  final mockInputConverter = MockInputConverter();

  final bloc = NumberTriviaBloc(
    concrete: mockGetConcreteNumberTrivia,
    random: mockGetRandomNumberTrivia,
    inputConverter: mockInputConverter,
  );

  test('initialState should be Empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'Test text', number: 1);

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(tNumberString))
          .thenReturn(const Right(tNumberParsed));
    }

    // test(
    //     'should call the InputConverter to validate and convert the string to an unsigned integer',
    //     () async {
    //   setUpMockInputConverterSuccess();
    //
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    //   await untilCalled(
    //       mockInputConverter.stringToUnsignedInteger(tNumberString));
    //   verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    // });

    // test('should emit [Error] when the input is invalid', () async {
    //   when(mockInputConverter.stringToUnsignedInteger(tNumberString))
    //       .thenReturn(Left(InvalidInputFailure()));
    //   final expected = [
    //     Empty(),
    //     Error(message: INVALUD_INPUT_FAILURE_MESSAGE),
    //   ];
    //   expectLater(bloc.state, emitsInOrder(expected));
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    // });

    // test('should get data from the concrete use case', () async {
    //   setUpMockInputConverterSuccess();
    //   when(mockGetConcreteNumberTrivia(const Param(number: tNumberParsed)))
    //       .thenAnswer((_) async => const Right(tNumberTrivia));
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    //   await untilCalled(
    //       mockGetConcreteNumberTrivia(const Param(number: tNumberParsed)));
    //   verify(
    //       mockGetConcreteNumberTrivia(const Param(number: tNumberParsed)));
    // });
    //
    // test('should emit [Loading, Loaded] when data is gotten successfully.',
    //     () async {
    //   setUpMockInputConverterSuccess();
    //   when(mockGetConcreteNumberTrivia(const Param(number: tNumberParsed)))
    //       .thenAnswer((_) async => const Right(tNumberTrivia));
    //
    //   final expected = [
    //     Empty(),
    //     Loading(),
    //     Loaded(trivia: tNumberTrivia),
    //   ];
    //   expectLater(bloc.state, emitsInOrder(expected));
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    // });
  });
}

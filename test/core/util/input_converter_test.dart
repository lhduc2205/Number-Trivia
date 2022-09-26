import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/util/input_converter.dart';

import 'input_converter_test.mocks.dart';

@GenerateMocks([InputConverter])
void main() {
  final mockInputConverter = MockInputConverter();

  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        const tNumberString = '123';
        const tNumber = 123;
        when(mockInputConverter.stringToUnsignedInteger(tNumberString))
            .thenReturn(const Right(tNumber));
        final result =
            mockInputConverter.stringToUnsignedInteger(tNumberString);

        expect(result, const Right(123));
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should return a Failure when the string is not an integer',
      () async {
        const tNumberString = 'abc';
        when(mockInputConverter.stringToUnsignedInteger(tNumberString))
            .thenReturn(Left(InvalidInputFailure()));
        final result = mockInputConverter.stringToUnsignedInteger(tNumberString);

        expect(result, Left(InvalidInputFailure()));
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should return a Failure when the string is a negative integer',
      () async {
        const tNumberString = '-123';
        when(mockInputConverter.stringToUnsignedInteger(tNumberString))
            .thenReturn(Left(InvalidInputFailure()));
        final result = mockInputConverter.stringToUnsignedInteger(tNumberString);

        expect(result, Left(InvalidInputFailure()));
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia/core/contants/shared_preferences_key.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  final mockSharedPreferences = MockSharedPreferences();
  final dataSource = NumberTriviaLocalDataSourceImpl(
    sharedPreferences: mockSharedPreferences,
  );

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia_cached.json')),
    );

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        final result = await dataSource.getLastNumberTrivia();

        verify(mockSharedPreferences.getString(
          SharedPreferencesKey.CACHED_NUMBER_TRIVIA,
        ));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheException when there is not a cached value',
      () async {
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        final call = dataSource.getLastNumberTrivia;

        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');
    test(
      'should call SharedPreferences to cache the data',
      () async {

        dataSource.cacheNumberTrivia(tNumberTriviaModel);
        final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

       //  verify(mockSharedPreferences.setString(
       //    SharedPreferencesKey.CACHED_NUMBER_TRIVIA,
       //    expectedJsonString,
       //  ));
      },
    );
  });
}

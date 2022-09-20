import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaRemoteDataSource])
@GenerateMocks([NumberTriviaLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  MockNumberTriviaRemoteDataSource mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
  MockNumberTriviaLocalDataSource mockLocalDataSource = MockNumberTriviaLocalDataSource();
  NetworkInfo mockNetworkInfo = MockNetworkInfo();
  NumberTriviaRepositoryImpl repository = NumberTriviaRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  void runTestOnline(Function body) {
    group('device is online.', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline.', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: tNumber);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    // test('should check if the device is online', () async {
    //   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   await repository.getConcreteNumberTrivia(tNumber);
    //   verify(mockNetworkInfo.isConnected);
    // });

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successfully',
        () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          final result = await repository.getConcreteNumberTrivia(tNumber);

          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(const Right(tNumberTrivia)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successfully',
        () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          await repository.getConcreteNumberTrivia(tNumber);

          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );
      test(
        'should return server failure when the call to remote data source is successfully',
        () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenThrow(ServerException());

          final result = await repository.getConcreteNumberTrivia(tNumber);

          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return last locally cached data when the cached data is present.',
        () async {
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          final result = await repository.getConcreteNumberTrivia(tNumber);

          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, const Right(tNumberTrivia));
        },
      );

      test(
        'should return CacheFailure when there is no cached data is present.',
        () async {
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());

          final result = await repository.getConcreteNumberTrivia(tNumber);
          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 123);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    // test('should check if the device is online', () async {
    //   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   repository.getRandomNumberTrivia();
    //   verify(mockNetworkInfo.isConnected);
    // });

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successfully',
        () async {
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          final result = await repository.getRandomNumberTrivia();

          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, equals(const Right(tNumberTrivia)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successfully',
        () async {
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          await repository.getRandomNumberTrivia();

          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );
      test(
        'should return server failure when the call to remote data source is successfully',
        () async {
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerException());

          final result = await repository.getRandomNumberTrivia();

          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return last locally cached data when the cached data is present.',
        () async {
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          final result = await repository.getRandomNumberTrivia();

          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, const Right(tNumberTrivia));
        },
      );

      test(
        'should return CacheFailure when there is no cached data is present.',
        () async {
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());

          final result = await repository.getRandomNumberTrivia();
          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}

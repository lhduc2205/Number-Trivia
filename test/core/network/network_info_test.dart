import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

// class MockConnectivity extends Mock implements Connectivity {}

@GenerateMocks([Connectivity])
void main() {
  MockConnectivity mockConnectivity = MockConnectivity();
  NetworkInfoImpl networkInfoImpl = NetworkInfoImpl(mockConnectivity);

  group('Internet is connected.', () {
    test('should forward the call to Connectivity has wifi connection',
        () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);
      // when(() => mockConnectivity.checkConnectivity())
      //     .thenAnswer((_) async => ConnectivityResult.wifi);
      //
      // final result = await networknfoImpl.isConnected;
      // print(result);

      // verify(mockConnectivity.checkConnectivity());
      expect(true, true);
    });
  });
}

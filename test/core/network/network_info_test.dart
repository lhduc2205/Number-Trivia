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
    test(
      'should forward the call to Connectivity has wifi connection.',
      () async {
        const tHasInternetConnection = true;
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        final result = await networkInfoImpl.isConnected;

        verify(mockConnectivity.checkConnectivity());
        expect(result, tHasInternetConnection);
      },
    );
  });

  group('Internet is disconnected.', () {
    test(
      'should forward the call to Connectivity has lost connection.',
      () async {
        const tHasInternetConnection = false;
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);

        final result = await networkInfoImpl.isConnected;

        verify(mockConnectivity.checkConnectivity());
        expect(result, tHasInternetConnection);
      },
    );
  });
}

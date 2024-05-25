import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nearfleet_app/config/network/network_service.dart';
import 'package:nearfleet_app/domain/entities/entities.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  MockDio mockDio = MockDio();
  late NetworkService networkService;

  setUp(() {
    networkService = NetworkService(mockDio);
  });


  group('Fetch data', () {
    test('Returns data if the http call completes successfully', () async {
      // Arrange
      const endpoint = 'http://localhost:8000/api/address';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: endpoint),
        data: [Address.mockModel()],
        statusCode: 200,
      );

      when(mockDio.get(endpoint)).thenAnswer((_) async => mockResponse);

      // Act
      final response = await networkService.get(endpoint);

      // Assert
      expect(response.data, [Address.mockModel()]);
    });
  });


}
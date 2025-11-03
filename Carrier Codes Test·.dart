import 'package:flutter_test/flutter_test.dart';
import 'package:carrier_codes_manager/carrier_codes_manager.dart';

void main() {
  group('CarrierCodes Tests', () {
    final carrierCodes = CarrierCodes({
      'MCI': '0910,0911,0912,0990,0991,0992',
      'IRANCEL': '0930,0933,0935,0900,0901',
      'RIGHTEL': '0920,0921,0922',
    });

    test('Organized map should have correct keys', () {
      expect(carrierCodes.organized.keys, containsAll(['MCI', 'IRANCEL', 'RIGHTEL']));
    });

    test('Should return all codes correctly', () {
      expect(carrierCodes.allCodes.length, greaterThan(5));
      expect(carrierCodes.allCodes, contains('0910'));
    });

    test('Should fetch correct codes by carrier', () {
      final mciCodes = carrierCodes.codesOf('MCI');
      expect(mciCodes, contains('0910'));
      expect(mciCodes.length, equals(6));
    });

    test('Should find correct carrier by code', () {
      expect(carrierCodes.carrierOf('0900'), equals('IRANCEL'));
      expect(carrierCodes.carrierOf('0992'), equals('MCI'));
      expect(carrierCodes.carrierOf('0000'), equals(''));
    });

    test('Should count codes correctly', () {
      final counts = carrierCodes.counts;
      expect(counts['MCI'], equals(6));
      expect(counts['RIGHTEL'], equals(3));
    });

    test('Should detect valid and invalid codes', () {
      expect(carrierCodes.isValid('0910'), isTrue);
      expect(carrierCodes.isValid('0999'), isFalse);
    });

    test('Should return empty list for unknown carrier', () {
      expect(carrierCodes.codesOf('UNKNOWN'), isEmpty);
    });

    test('Should return duplicates correctly', () {
      final dupTest = CarrierCodes({
        'A': '111,222,333',
        'B': '222,444',
      });
      expect(dupTest.duplicates, equals(['222']));
    });

    test('Should return unique codes correctly', () {
      final uniqueTest = CarrierCodes({
        'A': '111,222,333',
        'B': '222,444',
      });
      expect(uniqueTest.uniques, containsAll(['111', '333', '444']));
    });

    test('Should identify empty carriers', () {
      final emptyTest = CarrierCodes({
        'A': '',
        'B': '111,222',
      });
      expect(emptyTest.emptyCarriers, equals(['A']));
    });
  });
}

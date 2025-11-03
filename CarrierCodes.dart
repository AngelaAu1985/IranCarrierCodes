import 'dart:convert';

/// 🌐 Carrier Codes Manager
/// A clean, elegant utility for managing mobile carrier codes.
/// Includes validation, analysis, and search capabilities.
class CarrierCodes {
  /// Stores the raw carrier data.
  final Map<String, String> rawCodes;

  /// Creates a [CarrierCodes] instance.
  /// Invalid inputs are automatically replaced with an empty map.
  CarrierCodes(Map<String, String>? input)
      : rawCodes = (input != null && input is Map<String, String>) ? input : {} {
    if (input == null || input is! Map<String, String>) {
      print('❌ Invalid input: Expected Map<String, String>. Using empty map.');
    }
  }

  /// Returns a structured version of the raw data.
  Map<String, List<String>> get organized {
    return rawCodes.map((carrier, codes) {
      final cleanCodes = codes
          .split(',')
          .map((c) => c.trim())
          .where((c) => c.isNotEmpty)
          .toList();
      return MapEntry(carrier.toUpperCase(), cleanCodes);
    });
  }

  /// Pretty print organized data in JSON format.
  void display() {
    final formatted = const JsonEncoder.withIndent('    ').convert(organized);
    print('\n📦 Carrier Code Summary:\n$formatted');
  }

  /// Returns all codes from all carriers.
  List<String> get allCodes => organized.values.expand((v) => v).toList();

  /// Fetch all codes for a given [carrier].
  List<String> codesOf(String carrier) => organized[carrier.toUpperCase()] ?? [];

  /// Find the carrier that owns a given [code].
  String? carrierOf(String code) => organized.entries
      .firstWhere((e) => e.value.contains(code), orElse: () => const MapEntry('', []))
      .key;

  /// Returns number of codes per carrier.
  Map<String, int> get counts =>
      organized.map((key, value) => MapEntry(key, value.length));

  /// Returns duplicate codes if any.
  List<String> get duplicates {
    final map = <String, int>{};
    for (var c in allCodes) {
      map[c] = (map[c] ?? 0) + 1;
    }
    return map.entries.where((e) => e.value > 1).map((e) => e.key).toList();
  }

  /// Returns unique (non-repeated) codes.
  List<String> get uniques {
    final map = <String, int>{};
    for (var c in allCodes) {
      map[c] = (map[c] ?? 0) + 1;
    }
    return map.entries.where((e) => e.value == 1).map((e) => e.key).toList();
  }

  /// Returns carriers that have no codes.
  List<String> get emptyCarriers =>
      organized.entries.where((e) => e.value.isEmpty).map((e) => e.key).toList();

  /// Checks if a code exists.
  bool isValid(String code) => allCodes.contains(code);
}

void main() {
  final codes = {
    'MCI': '0910,0911,0912,0913,0990,0991,0992',
    'IRANCEL': '0930,0933,0935,0936,0900,0901,0903',
    'RIGHTEL': '0920,0921,0922',
  };

  final manager = CarrierCodes(codes);

  print('''\n==============================
📱 Carrier Codes Analyzer
==============================''');

  manager.display();

  print('\n➡️ All Codes: ${manager.allCodes}');
  print('\n📡 IRANCEL Codes: ${manager.codesOf('IRANCEL')}');
  print('\n🔍 Carrier of 0903: ${manager.carrierOf('0903')}');
  print('\n📊 Code Counts: ${manager.counts}');
  print('\n♻️ Duplicates: ${manager.duplicates}');
  print('\n✨ Unique Codes: ${manager.uniques}');
  print('\n🚫 Empty Carriers: ${manager.emptyCarriers}');
  print('\n✅ Is 0910 valid? ${manager.isValid('0910')}');
  print('❌ Is 0999 valid? ${manager.isValid('0999')}');
}

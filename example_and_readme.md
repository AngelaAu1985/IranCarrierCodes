## 📘 Example: Using `carrier_codes_manager`

Create a file at `example/main.dart`:

```dart
import 'package:carrier_codes_manager/carrier_codes_manager.dart';

void main() {
  final carrierCodes = CarrierCodes({
    'MCI': '0910,0911,0912,0913,0990,0991,0992',
    'IRANCEL': '0930,0933,0935,0936,0900,0901,0903',
    'RIGHTEL': '0920,0921,0922',
  });

  print('''\n==============================
📱 Carrier Codes Analyzer Example
==============================''');

  carrierCodes.display();

  print('\n➡️ All Codes: ${carrierCodes.allCodes}');
  print('\n📡 IRANCEL Codes: ${carrierCodes.codesOf('IRANCEL')}');
  print('\n🔍 Carrier of 0903: ${carrierCodes.carrierOf('0903')}');
  print('\n📊 Code Counts: ${carrierCodes.counts}');
  print('\n♻️ Duplicates: ${carrierCodes.duplicates}');
  print('\n✨ Unique Codes: ${carrierCodes.uniques}');
  print('\n🚫 Empty Carriers: ${carrierCodes.emptyCarriers}');
  print('\n✅ Is 0910 valid? ${carrierCodes.isValid('0910')}');
  print('❌ Is 0999 valid? ${carrierCodes.isValid('0999')}');
}
```

---

## 📦 Installation

Add the following line to your project's `pubspec.yaml` under **dependencies**:

```yaml
dependencies:
  carrier_codes_manager: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

Import the package:

```dart
import 'package:carrier_codes_manager/carrier_codes_manager.dart';
```

Create an instance and analyze carrier codes:

```dart
final carrierCodes = CarrierCodes({
  'MCI': '0910,0911,0990',
  'IRANCEL': '0930,0901',
});

print(carrierCodes.counts); // {MCI: 3, IRANCEL: 2}
print(carrierCodes.carrierOf('0990')); // MCI
```

---

## 💡 Features

✅ Organize raw code data into structured format  
✅ Search by carrier or by code  
✅ Detect duplicate and unique codes  
✅ Pretty JSON display  
✅ Works in Flutter and pure Dart projects  

---

## 🧑‍💻 Author
**Reza Torabi**  
📧 reza@example.com  
🌍 [pub.dev/packages/carrier_codes_manager](https://pub.dev/packages/carrier_codes_manager)


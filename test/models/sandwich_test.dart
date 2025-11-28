// Dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('constructor assigns fields correctly', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.wheat,
      );
      expect(sandwich.type, SandwichType.chickenTeriyaki);
      expect(sandwich.isFootlong, true);
      expect(sandwich.breadType, BreadType.wheat);
    });

    test('name getter returns correct names', () {
      expect(
        Sandwich(type: SandwichType.veggieDelight, isFootlong: false, breadType: BreadType.white).name,
        'Veggie Delight',
      );
      expect(
        Sandwich(type: SandwichType.chickenTeriyaki, isFootlong: false, breadType: BreadType.white).name,
        'Chicken Teriyaki',
      );
      expect(
        Sandwich(type: SandwichType.tunaMelt, isFootlong: false, breadType: BreadType.white).name,
        'Tuna Melt',
      );
      expect(
        Sandwich(type: SandwichType.meatballMarinara, isFootlong: false, breadType: BreadType.white).name,
        'Meatball Marinara',
      );
    });

    test('image getter returns correct asset path for footlong', () {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      expect(sandwich.image, 'assets/images/tunaMelt_footlong.png');
    });

    test('image getter returns correct asset path for six-inch', () {
      final sandwich = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      expect(sandwich.image, 'assets/images/meatballMarinara_six_inch.png');
    });

    test('works with all bread types', () {
      for (final bread in BreadType.values) {
        final sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: bread,
        );
        expect(sandwich.breadType, bread);
      }
    });
  });
}
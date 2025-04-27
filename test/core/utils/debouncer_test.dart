import 'package:e_ommerce_product_listing_app/core/utils/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Debouncer', () {
    late Debouncer debouncer;
    late int callCount;

    setUp(() {
      debouncer = Debouncer(milliseconds: 300);
      callCount = 0;
    });

    tearDown(() {
      debouncer.dispose();
    });

    test('calls action after delay', () async {
      debouncer.run(() {
        callCount++;
      });

      expect(callCount, 0);

      await Future<dynamic>.delayed(const Duration(milliseconds: 350));

      expect(callCount, 1);
    });

    test('cancels previous call if new run is called', () async {
      debouncer.run(() {
        callCount++;
      });

      await Future<dynamic>.delayed(const Duration(milliseconds: 100));

      debouncer.run(() {
        callCount++;
      });

      await Future<dynamic>.delayed(const Duration(milliseconds: 350));

      expect(callCount, 1);
    });

    test('does not call action if disposed before timer fires', () async {
      debouncer.run(() {
        callCount++;
      });

      debouncer.dispose();

      await Future<dynamic>.delayed(const Duration(milliseconds: 400));

      expect(callCount, 0);
    });
  });
}

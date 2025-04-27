import 'package:flutter_test/flutter_test.dart';
import 'package:e_ommerce_product_listing_app/core/errors/failures.dart';

void main() {
  group('FailureExtensions', () {
    test('returns correct user friendly message for UnexpectedFailure', () {
      final Failure failure = Failure.unexpected(
        message: 'Unexpected error',
        stackTrace: StackTrace.current,
      );
      expect(failure.userFriendlyMessage, contains('Unexpected error'));
    });

    test('returns correct user friendly message for NetworkFailure', () {
      final Failure failure = Failure.network(
        message: 'Network error',
        stackTrace: StackTrace.current,
      );
      expect(failure.userFriendlyMessage, contains('Network error'));
    });

    test('returns correct user friendly message for CacheFailure', () {
      final Failure failure = Failure.cache(
        message: 'Cache error',
        stackTrace: StackTrace.current,
      );
      expect(failure.userFriendlyMessage, contains('Storage error'));
    });

    test(
      'returns correct user friendly message for ServerFailure with 500',
      () {
        final Failure failure = Failure.server(
          message: 'Server error',
          statusCode: 500,
          responseData: null,
          stackTrace: StackTrace.current,
        );
        expect(
          failure.userFriendlyMessage,
          contains('Server maintenance in progress'),
        );
      },
    );

    test(
      'returns correct user friendly message for ServerFailure with non-500',
      () {
        final Failure failure = Failure.server(
          message: 'Server error',
          statusCode: 404,
          responseData: null,
          stackTrace: StackTrace.current,
        );
        expect(failure.userFriendlyMessage, contains('Server error (404)'));
      },
    );
  });
}

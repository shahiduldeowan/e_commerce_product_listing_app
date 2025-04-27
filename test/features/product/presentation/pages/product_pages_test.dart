import 'package:bloc_test/bloc_test.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/widgets/product_item_widget.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/pages/product_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  group('ProductPages Widget Tests', () {
    late ProductBloc productBloc;

    setUp(() {
      productBloc = MockProductBloc();
    });

    tearDown(() {
      productBloc.close();
    });

    Widget buildTestableWidget(Widget body) {
      return MaterialApp(
        home: BlocProvider<ProductBloc>.value(value: productBloc, child: body),
      );
    }

    const ProductEntity tProductEntity = ProductEntity(
      id: 1,
      title: 'Test Product',
      price: 100.0,
      description: 'Test Description',
      category: 'Test Category',
      images: <String>['https://example.com/image.png'],
      isFavorite: false,
    );

    testWidgets('shows loading indicator when status is loading', (
      WidgetTester tester,
    ) async {
      when(
        () => productBloc.state,
      ).thenReturn(const ProductState(status: ProductStatus.loading));

      await tester.pumpWidget(buildTestableWidget(const ProductPages()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows products grid when status is success', (
      WidgetTester tester,
    ) async {
      when(() => productBloc.state).thenReturn(
        const ProductState(
          status: ProductStatus.success,
          products: <ProductEntity>[tProductEntity],
          hasReachedMax: true,
        ),
      );

      await tester.pumpWidget(buildTestableWidget(const ProductPages()));

      expect(find.byType(ProductItemWidget), findsOneWidget);
    });

    testWidgets('shows error message when status is failure', (
      WidgetTester tester,
    ) async {
      when(() => productBloc.state).thenReturn(
        const ProductState(
          status: ProductStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );

      await tester.pumpWidget(buildTestableWidget(const ProductPages()));

      expect(find.text('Something went wrong'), findsOneWidget);
    });
  });
}

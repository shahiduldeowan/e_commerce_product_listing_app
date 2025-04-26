import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPages extends StatelessWidget {
  const ProductPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: AppSiz,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Product Length ${state.products.length}'),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Go to Cart'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

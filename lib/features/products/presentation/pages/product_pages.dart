import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show AppSizes, SizeFormatExtension;
import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductPages extends StatelessWidget {
  const ProductPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: AppSizes.large.toHorizontalEdgeInsets(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Product Length ${state.products.length}'),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      width: double.maxFinite,
                      child: MasonryGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSizes.large,
                        mainAxisSpacing: AppSizes.large,
                        itemCount: state.products.length,
                        itemBuilder: (_, int index) {
                          return ProductItemWidget(
                            product: state.products[index],
                          );
                        },
                      ),
                    ),
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

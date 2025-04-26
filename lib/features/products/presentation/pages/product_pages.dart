import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show
        AppColors,
        AppSizes,
        LoadingIndicator,
        SizeFormatExtension,
        searchAnything;
import 'package:e_ommerce_product_listing_app/core/utils/debouncer.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductPages extends StatefulWidget {
  const ProductPages({super.key});

  @override
  State<ProductPages> createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: 500);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double scrollPercentage = (currentScroll / maxScroll) * 100;

    if (scrollPercentage >= 90) {
      _debouncer.run(() {
        context.read<ProductBloc>().add(const ProductEventFetchNext());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: AppSizes.large.toHorizontalEdgeInsets(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildSearchField(context),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     '${state.products.length} $items',
                    //     style: Theme.of(context).textTheme.labelLarge,
                    //   ),
                    // ),
                    const SizedBox(height: AppSizes.large),
                    _buildProductGrid(state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Expanded _buildProductGrid(ProductState state) {
    return Expanded(
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (_, ProductState state) {
          if (state.status == ProductStatus.success) {
            return MasonryGridView.count(
              controller: _scrollController,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.large,
              mainAxisSpacing: AppSizes.large,
              itemCount: state.products.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (_, int index) {
                if (index < state.products.length) {
                  return ProductItemWidget(product: state.products[index]);
                }
                return Padding(
                  padding: AppSizes.large.toAllEdgeInsets(),
                  child: const LoadingIndicator(),
                );
              },
            );
          }
          if (state.status == ProductStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? 'Error fetching products'),
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: const Icon(
          Icons.search,
          size: 24,
          color: AppColors.blueGray100,
        ),
        border: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        hintText: searchAnything,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        contentPadding: AppSizes.medium.toSymmetricEdgeInsets(
          vertical: AppSizes.small,
        ),
        suffixIcon:
            _searchController.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 24,
                    color: AppColors.blueGray100,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _searchFocusNode.requestFocus();
                  },
                )
                : null,
      ),
    );
  }

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSizes.small),
    borderSide: const BorderSide(color: AppColors.blueGray100, width: 1),
  );

  @override
  void dispose() {
    _scrollController.dispose();
    _debouncer.dispose();
    super.dispose();
  }
}

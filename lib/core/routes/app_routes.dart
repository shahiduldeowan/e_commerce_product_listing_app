import 'package:e_ommerce_product_listing_app/core/constants/route_names.dart';
import 'package:e_ommerce_product_listing_app/core/di/di.dart' show getIt;
import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/pages/product_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    RouteNames.initialPageRouteName:
        (_) => BlocProvider<ProductBloc>(
          create:
              (_) => getIt<ProductBloc>()..add(const ProductEventFetchInit()),
          child: const ProductPages(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = _routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute<Widget>(builder: builder, settings: settings);
    }
    return null;
  }
}

import 'package:e_ommerce_product_listing_app/core/services/navigation_services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async => $initGetIt(getIt);

@module
abstract class AppModule {
  @singleton
  NavigationService get navigationService => NavigationService();
}

part of 'product_bloc.dart';

@freezed
abstract class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchInit() = ProductEventFetchInit;
  const factory ProductEvent.fetchNext() = ProductEventFetchNext;
  const factory ProductEvent.refresh() = ProductEventRefresh;
}

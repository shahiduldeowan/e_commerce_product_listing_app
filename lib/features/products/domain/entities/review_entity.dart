import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_entity.freezed.dart';

@freezed
abstract class ReviewEntity with _$ReviewEntity {
  const factory ReviewEntity({
    int? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) = _ReviewEntity;
}

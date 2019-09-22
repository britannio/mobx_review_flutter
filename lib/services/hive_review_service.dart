import 'package:hive/hive.dart';
import 'package:mobx_review/services/review_service.dart';

class HiveReviewService implements ReviewService {
  HiveReviewService(this.box);
  static const _reviewsKey = 'reviews';

  final Box box;

  @override
  List<String> getReviews() => box.get(_reviewsKey) as List<String> ?? [];

  @override
  void saveReviews(List<String> reviewList) => box.put(_reviewsKey, reviewList);
}

import 'package:mobx_review/services/review_service.dart';

class MockReviewService implements ReviewService {
  List<String> reviews = [];

  @override
  List<String> getReviews() => reviews;

  @override
  void saveReviews(List<String> reviewList) => reviews = reviewList;
}

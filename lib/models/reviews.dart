import 'dart:async';
import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:mobx_review/models/review_model.dart';
import 'package:mobx_review/service_locator.dart';
import 'package:mobx_review/services/review_service.dart';
part 'reviews.g.dart';

class Reviews = ReviewsBase with _$Reviews;

abstract class ReviewsBase with Store {
  @observable
  ObservableList<ReviewModel> reviews = ObservableList.of([]);

  @observable
  double averageStars = 0;

  @computed
  int get numberOfReviews => reviews.length;

  int totalStars = 0;

  final ReviewService _reviewService = sl<ReviewService>();

  @action
  void addReview(ReviewModel newReview) {
    //to update list of reviews
    reviews.add(newReview);
    // to update the average number of stars
    averageStars = _calculateAverageStars(newReview.stars);
    // to update the total number of stars
    totalStars += newReview.stars;
    // to store the reviews using Shared Preferences
    _persistReview(reviews);
  }

  @action
  Future<void> initReviews() async {
    final List<ReviewModel> reviewList = await _getReviews();

    reviews = ObservableList.of(reviewList);

    for (ReviewModel review in reviews) {
      totalStars += review.stars;
    }
    averageStars = reviews.length != 0 ? (totalStars / reviews.length) : 0;
  }

  double _calculateAverageStars(int newStars) {
    return (newStars + totalStars) / numberOfReviews;
  }

  Future<void> _persistReview(List<ReviewModel> updatedReviews) async {
    List<String> reviewsStringList = [];

    for (ReviewModel review in updatedReviews) {
      Map<String, dynamic> reviewMap = review.toJson();
      String reviewString = jsonEncode(ReviewModel.fromJson(reviewMap));
      reviewsStringList.add(reviewString);
    }

    _reviewService.saveReviews(reviewsStringList);
  }

  Future<List<ReviewModel>> _getReviews() async {
    final List<String> reviewsStringList = _reviewService.getReviews();

    final List<ReviewModel> retrievedReviews = [];

    for (String reviewString in reviewsStringList) {
      Map<String, dynamic> reviewMap = jsonDecode(reviewString);
      ReviewModel review = ReviewModel.fromJson(reviewMap);
      retrievedReviews.add(review);
    }

    return retrievedReviews;
  }
}

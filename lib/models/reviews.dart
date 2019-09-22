import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_review/models/review_model.dart';
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

  static Box box;

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
    await _getReviews().then((onValue) {
      reviews = ObservableList.of(onValue);
      for (ReviewModel review in reviews) {
        totalStars += review.stars;
      }
    });
    averageStars = totalStars / reviews.length;
  }

  double _calculateAverageStars(int newStars) {
    return (newStars + totalStars) / numberOfReviews;
  }

  bool _isBoxOpen() => Hive.isBoxOpen('reviews');
  Future<Box> _openBox() => Hive.openBox('reviews');
  Future<void> _initBox() async {
    if (!_isBoxOpen() || box == null) {
      box = await _openBox();
    }
  }

  Future<void> _persistReview(List<ReviewModel> updatedReviews) async {
    List<String> reviewsStringList = [];

    await _initBox();

    for (ReviewModel review in updatedReviews) {
      Map<String, dynamic> reviewMap = review.toJson();
      String reviewString = jsonEncode(ReviewModel.fromJson(reviewMap));
      reviewsStringList.add(reviewString);
    }

    await box.put('user_reviews', reviewsStringList);
  }

  Future<List<ReviewModel>> _getReviews() async {
    await _initBox();

    final List<String> reviewsStringList = box.get(
      'user_reviews',
      defaultValue: [],
    );

    final List<ReviewModel> retrievedReviews = [];

    for (String reviewString in reviewsStringList) {
      Map<String, dynamic> reviewMap = jsonDecode(reviewString);
      ReviewModel review = ReviewModel.fromJson(reviewMap);
      retrievedReviews.add(review);
    }

    return retrievedReviews;
  }
}

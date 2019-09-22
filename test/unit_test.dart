import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_review/models/review_model.dart';
import 'package:mobx_review/models/reviews.dart';

void main() {
  test('Test MobX state class', () async {
    final Reviews _reviewsStore = Reviews();

    await _reviewsStore.initReviews();

    expect(_reviewsStore.totalStars, 0);

    expect(_reviewsStore.averageStars, 0);
    _reviewsStore.addReview(
      ReviewModel(comment: 'This is a test review', stars: 3),
    );

    expect(_reviewsStore.totalStars, 3);
    _reviewsStore.addReview(
      ReviewModel(comment: 'This is a second test review', stars: 5),
    );

    expect(_reviewsStore.averageStars, 4);
  }, skip: true);
}

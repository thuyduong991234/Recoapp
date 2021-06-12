import 'package:recoapp/src/models/review.dart';
import 'package:recoapp/src/resources/review/review_api_provider.dart';

class ReviewRepository {
  final reviewApiProvider = ReviewApiProvider();

  Future<String> createReview(String title, String content, int user, int point,
          int checkin, List<int> tags, List<String> photos) =>
      reviewApiProvider.createReview(
          title, content, user, point, checkin, tags, photos);

  Future<List<Object>> fetchAllReviews({int page}) =>
      reviewApiProvider.fetchAllReviews(page: page);

  Future<Review> getDetailReview({int id}) =>
      reviewApiProvider.getDetailReview(id: id);

  Future<String> followReview({int idUser, int idReview, bool isLiked}) =>
      reviewApiProvider.followReview(
          idUser: idUser, idReview: idReview, isLiked: isLiked);

  Future<List<Object>> fetchAllReviewsByDinner({int idUser, int page}) => reviewApiProvider.fetchAllReviewsByDinner(idUser: idUser, page: page);
}

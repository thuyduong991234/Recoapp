import 'package:recoapp/src/models/comment.dart';
import 'package:recoapp/src/resources/comment/comment_api_provider.dart';

class CommentRepository {
  final commentApiProvider = CommentApiProvider();

  Future<String> createComment(
          int starFood,
          int starService,
          int starAmbious,
          int starNoise,
          String comment,
          int idRestaurant,
          int idReservation,
          int idUser,
          List<String> photos) =>
      commentApiProvider.createComment(starFood, starService, starAmbious,
          starNoise, comment, idRestaurant, idReservation, idUser, photos);

  Future<List<Object>> fetchCommentsByUser({int page, int idUser}) =>
      commentApiProvider.fetchCommentsByUser(page: page, idUser: idUser);

      Future<List<Object>> fetchCommentsByRestaurant({int page, int idRestaurant}) =>
      commentApiProvider.fetchCommentsByRestaurant(page: page, idRestaurant: idRestaurant);

  Future<Comment> getDetailComment({int id}) =>
      commentApiProvider.getDetailComment(id: id);
}

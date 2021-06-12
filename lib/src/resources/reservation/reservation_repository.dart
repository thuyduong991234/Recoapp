import 'package:recoapp/src/models/reservation.dart';
import 'package:recoapp/src/resources/reservation/reservation_api_provider.dart';

class ReservationRepository {
  final reservationApiProvider = ReservationApiProvider();

  Future<String> createReservation(Reservation reservation) =>
      reservationApiProvider.createReservation(reservation);

  Future<List<Object>> fetchReservationByType(
          {int idUser, int page, int type}) =>
      reservationApiProvider.fetchReservationByType(
          idUser: idUser, page: page, type: type);
}

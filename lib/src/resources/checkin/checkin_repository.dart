import 'package:recoapp/src/models/checkin.dart';
import 'package:recoapp/src/resources/checkin/checkin_api_provider.dart';

class CheckinRepository {
  final checkInApiProvider = CheckInApiProvider();

  Future<List<Object>> fetchAllCheckIns({int page}) =>
      checkInApiProvider.fetchAllCheckIns(page: page);
}

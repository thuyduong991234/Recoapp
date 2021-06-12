import 'package:recoapp/src/models/voucher.dart';
import 'package:recoapp/src/resources/voucher/voucher_api_provider.dart';


class VoucherRepository {
  final voucherApiProvider = VoucherApiProvider();

  Future<List<Voucher>> fetchAllVouchers({int idRestaurant}) => voucherApiProvider.fetchAllVouchers(idRestaurant: idRestaurant);

  Future<Voucher> getDetailVoucher({int idVoucher}) => voucherApiProvider.getDetailVoucher(idVoucher: idVoucher);
}
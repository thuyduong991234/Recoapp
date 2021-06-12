class Reservation {
  int id;
  int _idRestaurant;
  int _idVoucher;
  int _idUser;
  int _numberPerson;
  DateTime _time;
  String _fullname;
  String _phoneNumber;
  String _email;
  String _additionalInfo;
  String _code;
  String nameRestaurant;
  String detailAddress;
  String titleVoucher;

  int get idRestaurant => _idRestaurant;
  int get idVoucher => _idVoucher;
  int get idUser => _idUser;
  int get numberPerson => _numberPerson;
  DateTime get time => _time;
  String get fullname => _fullname;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get additionalInfo => _additionalInfo;
  String get code => _code;

  set idRestaurant(int idRestaurant) {
    this._idRestaurant = idRestaurant;
  }

  set idVoucher(int idVoucher) {
    this._idVoucher = idVoucher;
  }

  set idUser(int idUser) {
    this._idUser = idUser;
  }

  set numberPerson(int numberPerson) {
    this._numberPerson = numberPerson;
  }

  set time(DateTime time) {
    this._time = time;
  }

  set fullname(String fullname) {
    this._fullname = fullname;
  }

  set phoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;
  }

  set email(String email) {
    this._email = email;
  }

  set additionalInfo(String additionalInfo) {
    this._additionalInfo = additionalInfo;
  }

  set code(String code) {
    this._code = code;
  }

  Reservation(
      {int id,
      int idRestaurant,
      int idVoucher,
      int idUser,
      int numberPerson,
      DateTime time,
      String fullname,
      String phoneNumber,
      String email,
      String additionalInfo,
      String code,
      String nameRestaurant,
      String detailAddress,
      String title}) {
    this.id = id;
    this._idRestaurant = idRestaurant;
    this._idVoucher = idVoucher;
    this._idUser = idUser;
    this._numberPerson = numberPerson;
    this._time = time;
    this._fullname = fullname;
    this._phoneNumber = phoneNumber;
    this._email = email;
    this._additionalInfo = additionalInfo;
    this._code = code;
    this.nameRestaurant = nameRestaurant;
    this.detailAddress = detailAddress;
    this.titleVoucher = title;
  }

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
      id: json["id"],
      idRestaurant: json["restaurant"]["id"],
      nameRestaurant: json["restaurant"]["name"],
      detailAddress: json["restaurant"]["address"]["detail"],
      idVoucher: json["voucher"] != null ? json["voucher"]["id"] : null,
      code: json["voucher"] != null ? json["voucher"]["code"] : null,
      title: json["voucher"] != null ? json["voucher"]["title"] : null,
      fullname: json["fullName"],
      phoneNumber: json["phone"],
      email: json["email"],
      numberPerson: json["partySize"],
      additionalInfo: json["note"],
      time: DateTime.parse(json["timeComing"]));
}

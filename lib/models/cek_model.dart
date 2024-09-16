// ignore_for_file: non_constant_identifier_names

class CekModel {
  late final String UserUid;
  late final String kodeOrder;
  late final double totalPrice;
  late final String userName;
  late final String address;
  late final String status;
  late final DateTime time;
  late final String docId;
  late final String pengiriman;

  CekModel({
    required this.UserUid,
    required this.totalPrice,
    required this.kodeOrder,
    required this.userName,
    required this.address,
    required this.status,
    required this.time,
    required this.docId,
    required this.pengiriman,
  });

  Map<String, dynamic> toJson() => {
        'UserUid': UserUid,
        'totalPrice': totalPrice,
        'userName': userName,
        'kodeOrder': kodeOrder,
        'address': address,
        'status': status,
        'time': time,
        'docId': docId,
        'pengiriman': pengiriman,
      };

  static CekModel fromJson(Map<String, dynamic> json, String id) => CekModel(
        UserUid: json['UserUid'] ?? '',
        totalPrice: (json['totalPrice'] ?? 0).toDouble(),
        userName: json['userName'] ?? '',
        kodeOrder: json['kodeOrder'] ?? '',
        address: json['address'] ?? '',
        time: json['time'] != null ? json['time'].toDate() : DateTime.now(),
        status: json['status'] ?? '',
        pengiriman: json['pengiriman'] ?? '',
        docId: id,
      );
}

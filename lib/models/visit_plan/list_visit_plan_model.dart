class ListVisitPlanModel {
  ListVisitPlanModel({
    required this.customerid,
    required this.customer,
    required this.id,
    required this.checkin,
    required this.status,
    required this.pendingreason,
    required this.name,
    required this.venue,
    required this.tanggal,
    required this.catatanpending,
    required this.statusid,
  });

  String customerid;
  String customer;
  String id;
  String checkin;
  String status;
  String pendingreason;
  String name;
  String venue;
  String tanggal;
  String catatanpending;
  String statusid;

  factory ListVisitPlanModel.fromJson(Map<String, dynamic> json) =>
      ListVisitPlanModel(
        customerid: json["customerid"].toString(),
        customer: json["customer"].toString(),
        id: json["id"].toString(),
        checkin: json["checkin"].toString(),
        status: json["status"].toString(),
        pendingreason: json["pendingreason"].toString(),
        name: json["name"].toString(),
        venue: json["venue"].toString(),
        tanggal: DateTime.parse(json["tanggal"]).toString(),
        catatanpending: json["catatanpending"].toString(),
        statusid: json["statusid"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "customerid": customerid,
        "customer": customer,
        "id": id,
        "checkin": checkin,
        "status": status,
        "pendingreason": pendingreason,
        "name": name,
        "venue": venue,
        "tanggal": tanggal,
        "catatanpending": catatanpending,
        "statusid": statusid,
      };
}

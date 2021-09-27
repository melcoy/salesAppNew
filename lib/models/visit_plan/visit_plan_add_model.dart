class VisitPlanAddModel {
  String tanggal;
  String customer;
  String venue;

  VisitPlanAddModel(
      {required this.tanggal, required this.customer, required this.venue});

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "customer": customer,
        "venue": venue,
      };
}

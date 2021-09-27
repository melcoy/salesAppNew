class VisitPlanCheckInModel {
  String photo;
  String latitude;
  String longitude;

  VisitPlanCheckInModel(
      {required this.photo, required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "latitude": latitude,
        "longitude": longitude,
      };
}

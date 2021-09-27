class StatusVisitPlanModel {
  StatusVisitPlanModel({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory StatusVisitPlanModel.fromJson(Map<String, dynamic> json) =>
      StatusVisitPlanModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

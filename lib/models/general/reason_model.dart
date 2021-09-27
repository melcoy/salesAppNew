class ReasonModel {
  ReasonModel({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory ReasonModel.fromJson(Map<String, dynamic> json) => ReasonModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

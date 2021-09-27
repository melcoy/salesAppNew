class KotaModel {
  String id;
  String name;

  KotaModel({required this.id, required this.name});

  factory KotaModel.createCity(Map<String, dynamic> json) =>
      KotaModel(id: json["id"].toString(), name: json["name"].toString());

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

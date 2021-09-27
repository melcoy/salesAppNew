class ListTruckModel {
  String id;
  String name;

  ListTruckModel({
    required this.id,
    required this.name,
  });

  factory ListTruckModel.createList(Map<String, dynamic> json) =>
      ListTruckModel(
        id: json["id"].toString(),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

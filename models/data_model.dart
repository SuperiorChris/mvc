class DataModel {
  int id;
  String name;
  String description;

  DataModel({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
class DetailsModel {
  String? id;
  String? name;
  String? phone;
  String? age;
  String? imageUrl;
  String? department;
  DetailsModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.imageUrl,
    required this.department,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'age': age,
        'imageUrl': imageUrl,
        'department': department,
      };
  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        age: json['age'],
        imageUrl: json['id'],
        department: json['department'],
      );
}

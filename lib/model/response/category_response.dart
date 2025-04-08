// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

class CategoryItem {
  final String? id;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? code;
  final String? image;
  final String? description;
  final CategoryItem? parent;
  final List<CategoryItem>? subCategories;

  CategoryItem({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.code,
    required this.image,
    required this.description,
    required this.parent,
    required this.subCategories,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  CategoryItem copyWith({
    String? id,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? code,
    String? image,
    String? description,
    CategoryItem? parent,
    List<CategoryItem>? subCategories,
  }) =>
      CategoryItem(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        code: code ?? this.code,
        image: image ?? this.image,
        description: description ?? this.description,
        parent: parent ?? this.parent,
        subCategories: subCategories ?? this.subCategories,
      );

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        code: json["code"],
        image: json["image"],
        description: json["description"],
        parent: json["parent"] == null
            ? null
            : CategoryItem.fromJson(json["parent"]),
        subCategories: json["sub_categories"] == null
            ? null
            : List<CategoryItem>.from(
                json["sub_categories"].map((x) => CategoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "name": name,
        "code": code,
        "image": image,
        "description": description,
        "parent": parent!.toJson(),
        "sub_categories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class ProductModel {
  ProductModel({
    this.id,
    this.description,
    this.name,
    this.sku,
  });

  String id;
  String description;
  String name;
  String sku;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        description: json["description"],
        sku: json["sku"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "description": description, "name": name, "sku": sku};
}

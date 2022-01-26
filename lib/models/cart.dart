import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.id,
    this.status
  });

  String id;
  String status;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json["id"],
      status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status
  };
}

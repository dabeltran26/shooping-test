import 'dart:convert';

String productCartModelToJson(ProductCartModel data) =>
    json.encode(data.toJson());

class ProductCartModel {
  ProductCartModel({this.cartId, this.productId, this.quantity});

  String cartId;
  String productId;
  String quantity;

  factory ProductCartModel.fromJson(Map<String, dynamic> json) =>
      ProductCartModel(
          cartId: json["cart_id"],
          productId: json["product_id"],
          quantity: json["quantity"]);

  Map<String, dynamic> toJson() =>
      {"cartId": cartId, "productId": productId, "quantity": quantity};
}

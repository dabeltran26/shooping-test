import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/models/product_cart.dart';

class HomeRepository{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _url = 'shopping-tul-default-rtdb.firebaseio.com';

  Future<List<ProductModel>> getAllProducts() async{
    final url = Uri.https(_url, '/products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> data = json.decode(resp.body);
    final products = data.values.map((i)=>ProductModel.fromJson(i)).toList();
    return products;
  }

  Future<bool> addProduct(ProductModel product,CartModel cart,int quantity) async{
    final url = Uri.https(_url, '/product_carts/${_firebaseAuth.currentUser.uid}${product.id}.json');
    final body=jsonEncode(<String, String>{
      "product_id":"${product.id}",
      "cart_id":"${cart.id}",
      "quantity":quantity.toString(),
    });
    final resp = await http.patch(url,body: body);
    if(resp.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<List<ProductCartModel>> getProductsCart(String cardId) async {
    final url = Uri.https(_url, '/product_carts.json');
    final resp = await http.get(url);
    final Map<String, dynamic> data = json.decode(resp.body);
    final productsCart = data.values.map((i) => ProductCartModel.fromJson(i)).toList();
    List<ProductCartModel> products = [];
    for(int i = 0; i<productsCart.length; i++){
      if(productsCart[i].cartId == cardId){
        products.add(productsCart[i]);
      }
    }
    return products;
  }
}
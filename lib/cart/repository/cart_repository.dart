import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/models/cart.dart';

class CartRepository {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _url = 'shopping-tul-default-rtdb.firebaseio.com';

  Future<CartModel> getCart() async {
    final url = Uri.https(_url, '/carts.json');
    final resp = await http.get(url);
    final Map<String, dynamic> data = json.decode(resp.body);
    final carts = data.values.map((i) => CartModel.fromJson(i)).toList();
    CartModel cart;
    for(int i = 0; i<carts.length; i++){
      if(carts[i].id == _firebaseAuth.currentUser.uid){
        cart = carts[i];
      }
    }
    return cart;
  }

  Future<bool> createCart() async {
    final url = Uri.https(_url, '/carts/${_firebaseAuth.currentUser.uid}.json');
    final body=jsonEncode(<String, String>{
      "id":"${_firebaseAuth.currentUser.uid}",
      "status":"pending",
    });
    final resp = await http.patch(url,body: body);
    if(resp.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}
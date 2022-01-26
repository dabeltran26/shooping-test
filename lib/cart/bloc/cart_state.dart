import 'package:equatable/equatable.dart';
import 'package:shopping/models/product.dart';

abstract class CartState extends Equatable {

  const CartState();

  @override
  List<Object> get props => [];
}

class InitState extends CartState{}

class DataState extends CartState{
  final  List<ProductModel> myProducts;
  DataState(this.myProducts);
}
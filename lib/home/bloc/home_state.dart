import 'package:equatable/equatable.dart';
import 'package:shopping/models/product.dart';

abstract class HomeState extends Equatable {

  const HomeState();

  @override
  List<Object> get props => [];
}

class InitState extends HomeState{}

class DataState extends HomeState{
  final List<ProductModel> products;
  DataState(this.products);
}
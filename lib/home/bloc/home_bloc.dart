import 'package:bloc/bloc.dart';
import 'package:shopping/cart/repository/cart_repository.dart';
import 'package:shopping/home/bloc/home_event.dart';
import 'package:shopping/home/repository/product_repository.dart';
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/product.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{

  HomeRepository homeRepository = HomeRepository();
  CartRepository cartRepository = CartRepository();

  @override
  HomeState get initialState => InitState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    List<ProductModel> products;

    if(event is InitEvent){
      products = await homeRepository.getAllProducts();
      yield DataState(products);
    }

  }

  Future<bool> addToCart(ProductModel product,int quantity) async{
    CartModel cart = await cartRepository.getCart();
    if(cart == null){
      await cartRepository.createCart();
      cart = await cartRepository.getCart();
    }
    return await homeRepository.addProduct(product,cart,quantity);
  }
}
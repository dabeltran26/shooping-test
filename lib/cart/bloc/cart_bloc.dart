import 'package:bloc/bloc.dart';
import 'package:shopping/cart/repository/cart_repository.dart';
import 'package:shopping/home/repository/product_repository.dart';
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/models/product_cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent,CartState>{

  CartRepository cartRepository = CartRepository();
  HomeRepository homeRepository = HomeRepository();

  @override
  CartState get initialState => InitState();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    CartModel cart;
    List<ProductModel> myProducts = [];

    if(event is InitEvent){
      cart = await cartRepository.getCart();
      if(cart != null){
        List<ProductCartModel> productsCart = await homeRepository.getProductsCart(cart.id);
        List<ProductModel> products = await homeRepository.getAllProducts();
        for(int i = 0; i<productsCart.length; i++){
          for(int e = 0; e<products.length; e++){
            if(productsCart[i].productId == products[e].id){
              myProducts.add(products[e]);
            }
          }
        }
      }
      yield DataState(myProducts);
    }

  }

}
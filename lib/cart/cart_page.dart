import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/widgets/custom-button.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/cart_event.dart';
import 'bloc/cart_state.dart';

class CartPage extends StatefulWidget {

  static const routeName = 'cart';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(InitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Cart'),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: cartBloc,
        builder: (context, state) {

          if (state is DataState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 200,
                  child: ListView.builder(
                      itemCount: state.myProducts.length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(
                            trailing: Text(state.myProducts[index].sku),
                            title:Text(state.myProducts[index].name)
                        );
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(tittle: 'Pay order',onTap: (){}, circularBorder: true,),
                ),
              ],
            );
          }

          return Container(
            child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.amber,
                )),
          );
        },
      ),
    );
  }
}

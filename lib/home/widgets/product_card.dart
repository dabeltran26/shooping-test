import 'package:flutter/material.dart';
import 'package:shopping/home/bloc/home_bloc.dart';
import 'package:shopping/models/product.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;
  HomeBloc homeBloc = HomeBloc();

  ProductCard({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size padding = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(30),
      alignment: Alignment.centerLeft,
      height: 130,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color:  Color(0xffFCEBAF),
          borderRadius: BorderRadius.circular( 30 )
      ),
      child: Row(
        children: [
          Container(
              width: padding.width * 0.2,
              height: padding.width * 0.2,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage("https://soytul.com/wp-content/uploads/2020/01/favico_tul.jpg")))),
          SizedBox(width: 40,),
          Column(
            children: [
              Text(product.name,
                  style: TextStyle(fontWeight: FontWeight.normal)
                      .copyWith(color: Colors.black, fontSize: 13)),
              SizedBox(height: 5,),
              Text(product.description,maxLines: 3,
                  style: TextStyle(fontWeight: FontWeight.normal).copyWith(
                      color: Colors.black, fontSize: 14)),
              SizedBox(height: 5,),
              AddToCartButton(padding: padding,onTap: () async {
                bool isAdded = await homeBloc.addToCart(product,1);
                if(isAdded){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Product added",style: TextStyle(fontWeight: FontWeight.normal)
                        .copyWith(color: Colors.black, fontSize: 13)),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
                }
              },),
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final Size padding;
  final Function onTap;

  AddToCartButton({
    @required this.padding,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: padding.width * 0.25,
        height: padding.width * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.orange,
        ),
        child: Text('Add to cart', style: TextStyle( color: Colors.white ),),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/home/bloc/home_state.dart';
import 'package:shopping/home/widgets/product_card.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(InitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: homeBloc,
        builder: (context, state) {

          if (state is DataState) {

            final productItems = List.generate(state.products.length, (index) {
              return ProductCard(
                product: state.products[index],
              );
            });

            return CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                    floating: true,
                    delegate: _SliverCustomHeaderDelegate(
                        minheight: 70,
                        maxheight: 100,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                'Products',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 50),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'cart');
                                  },
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                    color: Colors.orange,
                                  ))
                            ],
                          ),
                        ))),
                SliverList(
                    delegate: SliverChildListDelegate([
                  ...productItems,
                ]))
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

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minheight;
  final double maxheight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {@required this.minheight,
      @required this.maxheight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxheight;

  @override
  double get minExtent => minheight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return maxheight != oldDelegate.maxheight ||
        minheight != oldDelegate.minheight ||
        child != oldDelegate.child;
  }
}

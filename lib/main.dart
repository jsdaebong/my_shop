import 'package:flutter/material.dart';
import 'package:my_shop2/providers/cart.dart';
import 'package:my_shop2/providers/orders.dart';
import 'package:my_shop2/providers/products.dart';
import 'package:my_shop2/screens/cart_screen.dart';
import 'package:my_shop2/screens/edit_product_screen.dart';
import 'package:my_shop2/screens/orders_screen.dart';
import 'package:my_shop2/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import 'package:my_shop2/screens/product_detail_screen.dart';
import 'package:my_shop2/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: 'Lato',
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

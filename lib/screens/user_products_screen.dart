import 'package:flutter/material.dart';
import 'package:my_shop2/providers/products.dart';
import 'package:my_shop2/screens/edit_product_screen.dart';
import 'package:my_shop2/widgets/app_drawer.dart';
import 'package:my_shop2/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(children: [
            UserProductItem(
              productsData.items[index].title,
              productsData.items[index].imageUrl,
            ),
            Divider(),
          ]),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}

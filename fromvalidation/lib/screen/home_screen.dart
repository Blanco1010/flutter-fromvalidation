import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/screens.dart';
import 'package:fromvalidation/services/services.dart';
import 'package:fromvalidation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      // appBar: AppBar(title: Text('Producto'), centerTitle: true),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: true,
            //Una imagen
            // flexibleSpace: FlexibleSpaceBar(),
            title: Text('Producto'),
            // expandedHeight: 150,
            centerTitle: true,
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return GestureDetector(
                  child: ProductCard(product: productsService.products[index]),
                  onTap: () => Navigator.pushNamed(context, 'product'));
            }, childCount: productsService.products.length),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}

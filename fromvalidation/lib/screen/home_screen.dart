import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fromvalidation/models/product.dart';

import 'package:fromvalidation/screen/screens.dart';

import 'package:fromvalidation/services/services.dart';

import 'package:fromvalidation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      // appBar: AppBar(title: Text('Producto'), centerTitle: true),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          const SliverAppBar(
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
                  onTap: () {
                    productsService.selectedProduct =
                        productsService.products[index].copy();
                    Navigator.pushNamed(context, 'product');
                  });
            }, childCount: productsService.products.length),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 40),
        onPressed: () {
          productsService.selectedProduct =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}

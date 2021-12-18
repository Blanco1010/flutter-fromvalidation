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
    final authService = Provider.of<AuthSerivce>(context, listen: false);

    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      // appBar: AppBar(title: Text('Producto'), centerTitle: true),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: true,
            //Una imagen
            // flexibleSpace: FlexibleSpaceBar(),
            title: const Text('Producto'),
            // expandedHeight: 150,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
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

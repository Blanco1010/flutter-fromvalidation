import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fromvalidation/ui/input_decorations.dart';

import 'package:fromvalidation/services/services.dart';

import 'package:fromvalidation/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () => Navigator.pop(context),
      //     child: Icon(Icons.exit_to_app),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(productService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 10,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 30,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:',
                  prefixIcon: Icon(Icons.account_box_sharp, color: Colors.red),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:',
                  prefixIcon: Icon(Icons.account_box_sharp, color: Colors.red),
                ),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
                title: Text('Disponible'),
                activeTrackColor: Colors.red[300],
                activeColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      );
}

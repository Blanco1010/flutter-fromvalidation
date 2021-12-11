import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fromvalidation/providers/product_form_provider.dart';
import 'package:fromvalidation/ui/input_decorations.dart';

import 'package:fromvalidation/services/services.dart';

import 'package:fromvalidation/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    // to handle the states in the form with ChangeNotifierProvider

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(
        productService: productService,
      ),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({required this.productService});

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // To hiden the keyboard when to drag the screen
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    onPressed: () async {
                      final _picker = new ImagePicker();
                      final XFile? _pickedFile = await _picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100,
                      );

                      if (_pickedFile == null) {
                        print('No seleccionó nada');
                        return;
                      }

                      print('Tenemos imagen ${_pickedFile.path}');
                      productService.updateSelectedProductImage(_pickedFile);
                    },
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
        onPressed: () async {
          FocusScope.of(context).unfocus();

          if (productForm.isValidForm()) {
            _showLoadingIndicator(context);
            await productService
                .saverOrCreateProduct(productService.selectedProduct);

            File _filePath = productService.newPictureFile!;

            if (productService.newPictureFile != null) {
              await productService.uploadFile(
                'multimedia-tienda/${productService.newNamePicture}',
                _filePath,
              );
            }
          } else {}

          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Future<dynamic> _showLoadingIndicator(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            backgroundColor: Colors.black,
            content: LoadingIndicator(text: 'Guardando'),
          ),
        );
      },
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:',
                  prefixIcon: Icon(Icons.account_box_sharp, color: Colors.red),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                validator: (value) {
                  if (value == null || value.length < 1) {
                    print('test');
                    return 'El nombre es obligatorio';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:',
                  prefixIcon: Icon(Icons.account_box_sharp, color: Colors.red),
                ),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: product.available,
                onChanged: (value) => productForm.updateAvailability(value),
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

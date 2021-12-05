import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 40),
      child: Container(
        decoration: _buildBoxDecoration(),
        height: 400,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: this.url == null
                  ? Image(
                      image: AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      image: NetworkImage(this.url!),
                      fit: BoxFit.cover,
                    )),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
        ]);
  }
}

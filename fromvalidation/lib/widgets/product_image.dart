import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
      child: Container(
        decoration: _buildBoxDecoration(),
        height: 400,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      color: Colors.black,
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
      ],
    );
  }

  Widget getImage(String? picture) {
    if (kDebugMode) {
      print(picture);
    }
    bool control = false;
    String name = '';
    if (picture != null) {
      name = (picture.split("/")[6]);
    } else {
      control = true;
    }
    if (picture == null) {
      return const Image(
        image: AssetImage('assets/img/no-image.png'),
        fit: BoxFit.cover,
      );
    }

    if (picture.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/img/jar-loading.gif'),
        image: NetworkImage(picture),
        fit: BoxFit.cover,
      );
    }

    if (control) {
      final ref =
          FirebaseStorage.instance.ref().child('/multimedia-tienda/$name');
      // no need of the file extension, the name will do fine.
      String url;

      return FutureBuilder(
        future: ref.getDownloadURL(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            url = snapshot.data;

            return DecoratedBox(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return const Image(
              image: AssetImage('assets/img/jar-loading.gif'),
              fit: BoxFit.cover,
            );
          }
        },
      );
    } else {
      return Image.file(File(picture));
    }
  }
}

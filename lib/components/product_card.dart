import 'package:flutter/material.dart';
import 'package:suzuri/models/product.dart';
import 'package:suzuri/pages/product_detail.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed(ProductDetail.routeName, arguments: this.product);
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.sampleImageUrl),
            SizedBox(
              height: 40.0,
              child: Text(product.title),
            ),
            Text("¥${product.price}"),
          ],
        ),
      ),
    );
  }
}

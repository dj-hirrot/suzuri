import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../requests/product_request.dart';

class ProductListStore extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  fetchNextProducts() async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    final request = ProductRequest(
      client: http.Client(),
      offset: _products.length,
    );

    final products = await request.fetch().catchError((e) {
      _isFetching = false;
    });

    _products.addAll(products);
    _isFetching = false;
    notifyListeners();
  }
}

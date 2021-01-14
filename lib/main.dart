import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:suzuri/pages/product_detail.dart';
import 'stores/product_list_store.dart';
import 'components/product_card.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProductListStore())
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ProductListStore>(context, listen: false);

    if (store.products.isEmpty && store.isFetching == false) {
      store.fetchNextProducts();
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
      routes: {
        ProductDetail.routeName: (context) => ProductDetail(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SUZURI"),
      ),
      body: _productList(context),
    );
  }

  Widget _productList(BuildContext context) {
    final store = Provider.of<ProductListStore>(context);
    final products = store.products;

    if (products.isEmpty) {
      return Container(
        color: Colors.white,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey,
              margin: EdgeInsets.all(16.0),
            );
          },
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.7,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      );
    }
  }
}

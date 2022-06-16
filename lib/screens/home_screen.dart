import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/bloc/product_bloc.dart';
import 'package:flutter_coffee_shop/components/appBar.dart';
import 'package:flutter_coffee_shop/components/card.dart';
import 'package:flutter_coffee_shop/models/product.dart';
import 'package:flutter_coffee_shop/screens/product_add_screen.dart';
import 'package:flutter_coffee_shop/screens/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(widget.title ?? 'Home'),
        appBar: AppBar(),
      ),
      body: FutureBuilder<List>(
        future: ProductBloc.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ProductList(list: snapshot.data)
              : Container(
                  alignment: Alignment.center,
                  color: const Color(0x78ffffff),
                  child: const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProductAddScreen(
                      isEdit: false,
                    )),
          );
        },
        backgroundColor: const Color(0xff5d4037),
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List? list;
  const ProductList({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemCount: list!.length,
      itemBuilder: (context, index) {
        return ProductCard(
          title:
              '${list![index].nama.toString()} (${list![index].jenis.toString()})',
          price: int.parse(list![index].harga.toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailScreen(product: list![index]),
              ),
            );
          },
        );
      },
    );
  }
}

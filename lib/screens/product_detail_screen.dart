import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_coffee_shop/bloc/product_bloc.dart';
import 'package:flutter_coffee_shop/components/appBar.dart';
import 'package:flutter_coffee_shop/screens/product_add_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, this.product, this.isEdit})
      : super(key: key);

  final dynamic? product;
  final bool? isEdit;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: const Text("Product Detail"),
          appBar: AppBar(),
        ),
        body: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.product!.nama,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Jenis : ${widget.product!.jenis}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Berat : ${widget.product!.berat.toString()} gr",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Harga : Rp. ${widget.product!.harga.toString()}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Stok : ${widget.product!.stok.toString()}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => onBuy(),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5d4037)),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Beli'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductAddScreen(
                          product: widget.product!,
                          isEdit: true,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5d4037)),
                    child: const Text('Edit'),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void onBuy() async {
    int stok = int.parse(widget.product!.stok.toString());
    Map<String, String> payload;

    if (stok > 0) {
      stok--;
      payload = {
        "stok": stok.toString(),
      };
      setState(() {
        isLoading = true;
      });

      var response = await ProductBloc.updateProduct(
          id: widget.product!.productId, payload: payload);

      print(response);

      setState(() {
        isLoading = false;
        widget.product!.stok = stok;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[200],
        content: const Text("Stok Habis"),
      ));
    }
  }
}

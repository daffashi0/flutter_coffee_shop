import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/bloc/product_bloc.dart';
import 'package:flutter_coffee_shop/components/appBar.dart';
import 'package:flutter_coffee_shop/components/card.dart';
import 'package:flutter_coffee_shop/models/product.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({Key? key, this.product, this.isEdit})
      : super(key: key);

  final dynamic? product;
  final bool? isEdit;

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final controllerPName = TextEditingController();
  final controllerPType = TextEditingController();
  final controllerPWeight = TextEditingController();
  final controllerPPrice = TextEditingController();
  final controllerPStock = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      controllerPName.text = widget.product!.nama.toString();
      controllerPType.text = widget.product!.jenis.toString();
      controllerPWeight.text = widget.product!.berat.toString();
      controllerPPrice.text = widget.product!.harga.toString();
      controllerPStock.text = widget.product!.stok.toString();
    }
  }

  @override
  void dispose() {
    controllerPName.dispose();
    controllerPType.dispose();
    controllerPWeight.dispose();
    controllerPPrice.dispose();
    controllerPStock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: const Text("Add Screen"),
          appBar: AppBar(),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controllerPName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nama'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controllerPType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Jenis'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controllerPWeight,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Berat (gr)'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controllerPPrice,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Harga'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controllerPStock,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Stok'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => onSubmit(),
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xff5d4037)),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text(widget.isEdit == true ? 'Edit' : 'Add'),
              ),
            ],
          ),
        ));
  }

  void onSubmit() {
    if (widget.isEdit == true) {
      doEdit();
    } else {
      doAdd();
    }
  }

  void doEdit() async {
    Map<String, String> payload = {
      "nama": controllerPName.text,
      "jenis": controllerPType.text,
      "harga": controllerPPrice.text.toString(),
      "berat": controllerPWeight.text.toString(),
      "stok": controllerPStock.text.toString(),
    };

    setState(() {
      isLoading = true;
    });

    var response = await ProductBloc.updateProduct(
        id: widget.product!.productId, payload: payload);

    if (response != null) {
      toast("Edit Success", false);
    } else {
      toast("Edit Failed", true);
    }

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context);
  }

  void doAdd() async {
    Product payload = Product(
      nama: controllerPName.text,
      jenis: controllerPType.text,
      harga: int.parse(controllerPPrice.text),
      berat: int.parse(controllerPWeight.text),
      stok: int.parse(controllerPStock.text),
    );

    setState(() {
      isLoading = true;
    });

    var response = await ProductBloc.addProduct(product: payload);

    if (response != null) {
      toast("Add Success", false);
    } else {
      toast("Add Failed", true);
    }

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context);
  }

  void toast(String text, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green[400],
      content: Text(text),
    ));
  }
}

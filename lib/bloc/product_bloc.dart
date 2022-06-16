import 'dart:convert';

import 'package:flutter_coffee_shop/models/product.dart';
import 'package:flutter_coffee_shop/services/api.dart';
import 'package:flutter_coffee_shop/services/constants.dart';

class ProductBloc {
  static String productUrl = AppConstants.PRODUCT_URL;

  static Future<List<Product>> getProduct() async {
    var response = await Api().get(Uri.parse(productUrl));
    var jsonObj = json.decode(response.body);

    print('JSON OBJ : $jsonObj');
    List<Product> products = [];

    for (int i = 0; i < jsonObj.length; i++) {
      products.add(Product.fromJson(jsonObj[i]));
    }

    return products;
  }

  static Future addProduct({Product? product}) async {
    print('cek masuk 1');
    var payload = {
      "nama": product!.nama,
      "jenis": product.jenis,
      "berat": product.berat.toString(),
      "harga": product.harga.toString(),
      "berat": product.berat.toString(),
      "stok": product.stok.toString(),
    };

    var response = await Api().post(productUrl, payload);
    var jsonObj = json.decode(response.body);

    print('cek masuk 2');
    return jsonObj;
  }

  static Future updateProduct({int? id, dynamic payload}) async {
    var response = await Api().patch('$productUrl/$id', payload);
    var jsonObj = json.decode(response.body);
    return jsonObj;
  }

  static Future<bool> deleteProduct({int? id}) async {
    var response = await Api().delete('$productUrl/$id');
    var jsonObj = json.decode(response.body);

    if (jsonObj != null) {
      return true;
    }

    return false;
  }
}

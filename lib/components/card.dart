import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String? title;
  final int? price;
  final Function()? onTap;

  const ProductCard({Key? key, this.title, this.price, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        color: const Color(0xff8b6b61),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              title!,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            Text(
              'Rp. ${price!.toString()}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  int? productId;
  String? nama;
  String? jenis;
  int? harga;
  int? berat;
  int? stok;

  Product(
      {this.productId,
      this.nama,
      this.jenis,
      this.harga,
      this.berat,
      this.stok});

  factory Product.fromJson(Map<String, dynamic> obj) {
    return Product(
      productId: int.parse(obj['id']),
      nama: obj['nama'],
      jenis: obj['jenis'],
      harga: int.parse(obj['harga']),
      berat: int.parse(obj['berat']),
      stok: int.parse(obj['stok']),
    );
  }
}

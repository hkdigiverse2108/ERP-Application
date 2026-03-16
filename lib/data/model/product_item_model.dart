class ProductItemModel {
  final String name;
  final String printName;
  final String category;
  final String brand;
  final String purchaseTax;
  final String saleTax;
  final String purchasePrice;
  final String mrp;
  final String salePrice;
  final String saleDiscount;

  final int qty;

  ProductItemModel({
    required this.name,
    required this.printName,
    required this.category,
    required this.brand,
    required this.purchaseTax,
    required this.saleTax,
    required this.purchasePrice,
    required this.mrp,
    required this.salePrice,
    required this.saleDiscount,
    required this.qty,
  });
}

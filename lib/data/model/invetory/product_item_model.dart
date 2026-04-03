class ProductItemModel {
  final String? name;
  final String? printName;
  final String? category;
  final String? subCategory;
  final String? brand;
  final String? subBrand;
  final String? purchaseTax;
  final String? saleTax;
  final String? purchasePrice;
  final String? mrp;
  final String? salePrice;
  final String? saleDiscount;

  final int qty;

  ProductItemModel({
    this.name,
    this.printName,
    this.category,
    this.subCategory,
    this.brand,
    this.subBrand,
    this.purchaseTax,
    this.saleTax,
    this.purchasePrice,
    this.mrp,
    this.salePrice,
    this.saleDiscount,
    this.qty = 0,
  });
}

class ProductItemModel {
  final String name;
  final String sku;
  final double price;
  final int quantity;
  final String unit;
  final double discount;
  final double tax;

  ProductItemModel({
    required this.name,
    this.sku = '',
    required this.price,
    required this.quantity,
    this.unit = 'Pcs',
    this.discount = 0,
    this.tax = 0,
  });

  double get subtotal => price * quantity;
  double get discountAmount => subtotal * (discount / 100);
  double get taxAmount => (subtotal - discountAmount) * (tax / 100);
  double get total => subtotal - discountAmount + taxAmount;
}

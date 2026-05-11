class LoyaltyDropdownModel {
  final String id;
  final String name;
  final String type;
  final double minimumPurchaseAmount;

  LoyaltyDropdownModel({
    required this.id,
    required this.name,
    required this.type,
    required this.minimumPurchaseAmount,
  });

  factory LoyaltyDropdownModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyDropdownModel(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      type: json["type"] ?? '',
      minimumPurchaseAmount: (json["minimumPurchaseAmount"] as num? ?? 0).toDouble(),
    );
  }
}

class LoyaltyRedeemResponse {
  final String loyaltyId;
  final String name;
  final String type;
  final double discountValue;

  LoyaltyRedeemResponse({
    required this.loyaltyId,
    required this.name,
    required this.type,
    required this.discountValue,
  });

  factory LoyaltyRedeemResponse.fromJson(Map<String, dynamic> json) {
    return LoyaltyRedeemResponse(
      loyaltyId: json["loyaltyId"] ?? '',
      name: json["name"] ?? '',
      type: json["type"] ?? '',
      discountValue: (json["discountValue"] as num? ?? 0).toDouble(),
    );
  }
}

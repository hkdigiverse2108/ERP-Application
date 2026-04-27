import 'package:equatable/equatable.dart';
import 'contact_model.dart';

class CustomerPosDetailsModel extends Equatable {
  final CustomerSummaryModel? customer;
  final double totalDueAmount;
  final double totalPaidAmount;
  final double totalPurchaseAmount;
  final LastBillModel? lastBill;
  final MostPurchasedProductModel? mostPurchasedProduct;

  const CustomerPosDetailsModel({
    this.customer,
    this.totalDueAmount = 0.0,
    this.totalPaidAmount = 0.0,
    this.totalPurchaseAmount = 0.0,
    this.lastBill,
    this.mostPurchasedProduct,
  });

  factory CustomerPosDetailsModel.fromMap(Map<String, dynamic> map) {
    return CustomerPosDetailsModel(
      customer: map['customer'] != null ? CustomerSummaryModel.fromMap(map['customer'] as Map<String, dynamic>) : null,
      totalDueAmount: (map['totalDueAmount'] as num? ?? 0).toDouble(),
      totalPaidAmount: (map['totalPaidAmount'] as num? ?? 0).toDouble(),
      totalPurchaseAmount: (map['totalPurchaseAmount'] as num? ?? 0).toDouble(),
      lastBill: map['lastBill'] != null ? LastBillModel.fromMap(map['lastBill'] as Map<String, dynamic>) : null,
      mostPurchasedProduct: map['mostPurchasedProduct'] != null 
          ? MostPurchasedProductModel.fromMap(map['mostPurchasedProduct'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customer': customer?.toMap(),
      'totalDueAmount': totalDueAmount,
      'totalPaidAmount': totalPaidAmount,
      'totalPurchaseAmount': totalPurchaseAmount,
      'lastBill': lastBill?.toMap(),
      'mostPurchasedProduct': mostPurchasedProduct?.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        customer,
        totalDueAmount,
        totalPaidAmount,
        totalPurchaseAmount,
        lastBill,
        mostPurchasedProduct,
      ];
}

class CustomerSummaryModel extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final ContactPhone? phoneNo;
  final ContactPhone? whatsappNo;
  final String status;
  final double loyaltyPoints;

  const CustomerSummaryModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    this.whatsappNo,
    required this.status,
    required this.loyaltyPoints,
  });

  factory CustomerSummaryModel.fromMap(Map<String, dynamic> map) {
    return CustomerSummaryModel(
      id: map['_id']?.toString() ?? "",
      firstName: map['firstName']?.toString() ?? "",
      lastName: map['lastName']?.toString() ?? "",
      email: map['email']?.toString(),
      phoneNo: map['phoneNo'] != null ? ContactPhone.fromMap(map['phoneNo'] as Map<String, dynamic>) : null,
      whatsappNo: map['whatsappNo'] != null ? ContactPhone.fromMap(map['whatsappNo'] as Map<String, dynamic>) : null,
      status: map['status']?.toString() ?? "",
      loyaltyPoints: (map['loyaltyPoints'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNo': phoneNo?.toMap(),
      'whatsappNo': whatsappNo?.toMap(),
      'status': status,
      'loyaltyPoints': loyaltyPoints,
    };
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, phoneNo, whatsappNo, status, loyaltyPoints];
}

class LastBillModel extends Equatable {
  final String id;
  final double totalAmount;
  final String orderNo;
  final String paymentMethod;
  final DateTime? createdAt;

  const LastBillModel({
    required this.id,
    required this.totalAmount,
    required this.orderNo,
    required this.paymentMethod,
    this.createdAt,
  });

  factory LastBillModel.fromMap(Map<String, dynamic> map) {
    return LastBillModel(
      id: map['_id']?.toString() ?? "",
      totalAmount: (map['totalAmount'] as num? ?? 0).toDouble(),
      orderNo: map['orderNo']?.toString() ?? "",
      paymentMethod: map['paymentMethod']?.toString() ?? "",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'totalAmount': totalAmount,
      'orderNo': orderNo,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, totalAmount, orderNo, paymentMethod, createdAt];
}

class MostPurchasedProductModel extends Equatable {
  final String id;
  final String name;

  const MostPurchasedProductModel({required this.id, required this.name});

  factory MostPurchasedProductModel.fromMap(Map<String, dynamic> map) {
    return MostPurchasedProductModel(
      id: map['_id']?.toString() ?? "",
      name: map['name']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}

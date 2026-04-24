import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/product_repository.dart';
import 'package:ai_setu/data/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeAddEditController extends GetxController {
  final RecipeRepository _recipeRepo = RecipeRepository();
  final ProductRepository _productRepo = ProductRepository();

  final formKey = GlobalKey<FormState>();
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxBool isActive = true.obs;
  Rx<RecipeType> recipeType = RecipeType.assemble.obs;

  final List<ProductDropdownModel> products = <ProductDropdownModel>[].obs;

  // Form Controllers
  final recipeNameController = TextEditingController();
  final recipeDate = Rxn<DateTime>();

  final ingredients = Rxn<List<RowProductModel>>();
  final product = Rxn<RowProductModel>();

  @override
  void onInit() {
    super.onInit();
    ingredients.value = [];
    product.value = RowProductModel();
  }
}

class RowProductModel {
  String? id;
  String? name;
  double? qty;
  double? amount;

  RowProductModel({this.id, this.name, this.qty, this.amount});

  factory RowProductModel.fromJson(Map<String, dynamic> json) =>
      RowProductModel(
        id: json['id'],
        name: json['name'],
        qty: json['qty'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'qty': qty,
    'amount': amount,
  };

  @override
  String toString() {
    return 'RowProductModel(id: $id, name: $name, qty: $qty, amount: $amount)';
  }
}

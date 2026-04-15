import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class ProductRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<ProductItemModel>> getProductsForTable({
    int? page,
    int? limit,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllProduct(
        page: page,
        limit: limit,
        search: search,
        activeFilter: filters?['activeFilter'],
        categoryFilter: filters?['categoryFilter'],
        brandFilter: filters?['brandFilter'],
        subCategoryFilter: filters?['subCategoryFilter'],
        subBrandFilter: filters?['subBrandFilter'],
        hsnCodeFilter: filters?['hsnCodeFilter'],
        purchaseTaxFilter: filters?['purchaseTaxFilter'],
        salesTaxIdFilter: filters?['salesTaxIdFilter'],
        productTypeFilter: filters?['productTypeFilter'],
      ),
    );

    if (res.status == 200 && res.data != null) {
      final items = (res.data['product_data'] as List)
          .map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromJson(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to load products');
  }

  Future<ProductModel> getProductById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getProductById(id));

    if (res.status == 200 && res.data != null) {
      return ProductModel.fromJson(res.data as Map<String, dynamic>);
    }

    throw Exception(res.message ?? 'Failed to load product');
  }

  Future<bool> addProduct(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(ApiConstants.addProduct, body: data);

    if (res.status == 200) {
      return true;
    }

    throw Exception(res.message ?? 'Failed to add product');
  }

  Future<bool> updateProduct(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(
      ApiConstants.updateProduct,
      body: data,
    );

    if (res.status == 200) {
      return true;
    }

    throw Exception(res.message ?? 'Failed to update product');
  }

  Future<List<CommonDropdownModel>> getProductDropdown() async {
    final ResModel res = await _api.get(ApiConstants.productDropdownNew);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => CommonDropdownModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to load product dropdown');
  }
}

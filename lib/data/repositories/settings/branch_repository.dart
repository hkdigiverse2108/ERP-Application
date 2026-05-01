import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/branch/branch_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class BranchRepository {
  final _api = ApiService.to;

  Future<List<BranchDropdownModel>> getBranchesDropdown() async {
    final ResModel response = await _api.get(ApiConstants.branchDropdown());

    if (response.status == 200) {
      final items = (response.data as List)
          .map((x) => BranchDropdownModel.fromJson(x))
          .toList();
      return items;
    }

    throw Exception(response.message ?? 'Failed to load branches');
  }
}

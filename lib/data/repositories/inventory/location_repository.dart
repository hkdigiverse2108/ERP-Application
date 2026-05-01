import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class LocationRepository {
  final _api = ApiService.to;

  Future<List<LocationDropdown>> countryDropdown() async {
    final ResModel res = await _api.get(ApiConstants.getCountry);

    if (res.status == 200) {
      return res.data
          .map<LocationDropdown>((json) => LocationDropdown.fromMap(json as Map<String, dynamic>))
          .toList();
    }

    throw Exception(res.message ?? "can't get the countrys");
  }

  Future<List<LocationDropdown>> stateDropdown(String? countryId) async {
    final ResModel res = await _api.get(ApiConstants.getState(id: countryId));

    if (res.status == 200) {
      return res.data
          .map<LocationDropdown>((json) => LocationDropdown.fromMap(json as Map<String, dynamic>))
          .toList();
    }

    throw Exception(res.message ?? "Can't get the states");
  }

  Future<List<LocationDropdown>> cityDropdown(String? stateId) async {
    final ResModel res = await _api.get(ApiConstants.getCity(id: stateId));
    if (res.status == 200) {
      return res.data
          .map<LocationDropdown>((json) => LocationDropdown.fromMap(json as Map<String, dynamic>))
          .toList();
    }

    throw Exception(res.message ?? "Can't get the cities");
  }
}

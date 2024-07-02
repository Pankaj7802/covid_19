import 'dart:convert';

import 'package:covid_19/model/world_states.dart';
import 'package:covid_19/service/Utilities/app_urs.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<Country> fecthWorkdStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Country.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}

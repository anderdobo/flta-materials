// 1
import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';
// 2
const String apiKey = '<Your Key Here>';
const String apiId = '<Your Id here>';
// 3
const String apiUrl = 'https://api.edamam.com';
// TODO: Add @ChopperApi() here



import 'dart:developer';

import 'package:http/http.dart';

const String apiKey = '13a052bb0ed69c91b4986f72a629cb08';
const String apiId = '430c5ea4';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService {
  Future getData(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log(response.body);
    }
  }

  Future<dynamic> getRecipes(String query, int from, int to) async {
    final recipeData = await getData(
        '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    return recipeData;
  }
}

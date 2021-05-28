import 'dart:convert';

import 'package:restauranes/constants.dart';
import 'package:http/http.dart' as http;

class FoodType {
  final String slug;
  final String? name;

  FoodType({required this.slug, required this.name});

  static FoodType? _fromResponse(Map data) {
    try {
      return FoodType(
        slug: data['slug'],
        name: data['name'] ?? ''
      );
    } catch (e) {
      return null;
    }
  }

    static Future<List<FoodType>?> get getFoodTypes async {
    try {
      Uri uri = Uri.parse('$Host/api/food_types');
      http.Response response = await http.get(uri);
      List result = json.decode(response.body);
      List<FoodType> types = [];
      result.forEach((element) {
        FoodType? tmp = _fromResponse(element);
        if (tmp != null) {
          types.add(tmp);
        }
      });
      return types;
    } catch (e) {
      return null;
    }
  }


  static List<FoodType> slugFoodTypes(List list) {
    List<FoodType> types = [];
    list.forEach((element) {
      types.add(FoodType(slug: element, name: null));
    });
    return types;
  }
}

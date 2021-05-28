import 'dart:convert';
import 'dart:io';

import 'package:restauranes/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restauranes/models/food_type.dart';
import 'package:restauranes/models/review.dart';

class Restaurant {
  final String slug;
  final String name;
  final String description;
  final String logo;
  final num rating;
  final List foodType;
  final List reviews;

  Restaurant(
      {required this.slug,
      required this.name,
      required this.description,
      required this.logo,
      required this.rating,
      required this.foodType,
      required this.reviews});

  static Restaurant? _fromResponse(Map data) {
    try {
      return Restaurant(
          slug: data['slug'],
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          logo: data['logo'] ?? '',
          rating: data['rating'] ?? 0,
          foodType: data['food_type'] != null
              ? FoodType.slugFoodTypes(data['food_type'])
              : [],
          reviews:
              data['reviews'] != null ? Review.reviews(data['reviews']) : []);
    } catch (e) {
      return null;
    }
  }

  static Future<List<Restaurant>?> get getRestaurants async {
    try {
      Uri uri = Uri.parse('$Host/api/restaurants');
      http.Response response = await http.get(uri);
      List result = json.decode(response.body);
      List<Restaurant> restaurants = [];
      result.forEach((element) {
        Restaurant? tmp = _fromResponse(element);
        if (tmp != null) {
          restaurants.add(tmp);
        }
      });
      return restaurants;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Restaurant>?> restaurantsFromFoodType(
      String slugFoodType) async {
    try {
      Uri uri =
          Uri.parse('$Host/api/restaurants/?food_type__slug=$slugFoodType');
      http.Response response = await http.get(uri);
      List result = json.decode(response.body);
      List<Restaurant> restaurants = [];
      result.forEach((element) {
        Restaurant? tmp = _fromResponse(element);
        if (tmp != null) {
          restaurants.add(tmp);
        }
      });
      return restaurants;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> createRestaurant(String name, String description,
      File image, List<FoodType> foodTypes) async {
    try {
      List<String> slugsFoodTypes = [];
      foodTypes.forEach((element) {
        slugsFoodTypes.add(element.slug);
      });
      Uri uri = Uri.parse('$Host/api/restaurants/');
      var request = http.MultipartRequest("POST", uri);
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['food_types'] = jsonEncode(slugsFoodTypes);
      request.files.add(http.MultipartFile.fromBytes(
          'logo', image.readAsBytesSync(),
          filename: image.path.split("/").last));
      var response = await request.send();
      print(response);
      return true;
    } catch (e) {
      return false;
    }
  }
}

import 'dart:convert';

import 'package:restauranes/constants.dart';
import 'package:http/http.dart' as http;

class Review {
  final String slug;
  final String restaurant;
  final String email;
  final String comments;
  final num rating;
  final DateTime created;

  Review(
      {required this.slug,
      required this.restaurant,
      required this.email,
      required this.comments,
      required this.rating,
      required this.created});

  static Review? _fromResponse(Map data) {
    try {
      return Review(
          slug: data['slug'],
          restaurant: data['restaurant'],
          email: data['email'] ?? '',
          comments: data['comments'] ?? '',
          rating: data['rating'] ?? 0,
          created: DateTime.parse(data['created'] ?? DateTime.now()));
    } catch (e) {
      return null;
    }
  }

  static List<Review> reviews(List list) {
    List<Review> reviews = [];
    list.forEach((element) {
      var tmp = _fromResponse(element);
      if (tmp != null) {
        reviews.add(tmp);
      }
    });
    return reviews;
  }

  static Future<bool> createReview(
      String slugRestaurant, String email, String comments, int rating) async {
    try {
      var body = jsonEncode(<String, dynamic>{
            "restaurant": slugRestaurant,
            "email": email,
            "comments": comments,
            "rating": rating
          }); 
      Uri uri = Uri.parse('$Host/api/reviews/');
      var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
          body: body);
      print(response);
      return true;
    } catch (e) {
      return false;
    }
  }
}

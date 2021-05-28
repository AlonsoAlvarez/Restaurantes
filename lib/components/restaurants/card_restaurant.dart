import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauranes/components/row_stars.dart';
import 'package:restauranes/models/restaurant.dart';
import 'package:restauranes/pages/restaurant_detail.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { 
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => PageRestaurant(
                      restaurant: restaurant,
                    ))); 
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(5)),
        height: 120,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    image: NetworkImage(restaurant.logo),
                    placeholder: AssetImage('assets/restaurant_fade.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 0,
                    right: 0,
                    bottom: 35,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurant.name,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          Text(restaurant.description,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 35,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RowStars(rating: restaurant.rating,),
                                  Text('${restaurant.reviews.length} reviews')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
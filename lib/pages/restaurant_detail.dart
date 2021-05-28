import 'package:flutter/material.dart';
import 'package:restauranes/components/restaurant_detail/alert_reviews.dart';
import 'package:restauranes/components/row_stars.dart';
import 'package:restauranes/models/restaurant.dart';
import 'package:restauranes/screens/show_img.dart';

class PageRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const PageRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle')
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowImage(
                                            place:
                                                'assets/restaurant_fade.jpeg',
                                            def: '${restaurant.logo}',
                                            hero: '${restaurant.slug}',
                                          )));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Hero(
                                    tag: '${restaurant.slug}',
                                    child: Image.network(restaurant.logo))),
                          )),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Column(children: [
                            Text(restaurant.name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500)),
                            Text(restaurant.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w300)),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowStars(rating: restaurant.rating,),
                                    Text('${restaurant.reviews.length} reviews')
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.white),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertReviews(reviews: restaurant.reviews, slugRestaurant: restaurant.slug,);
                                        });
                                  },
                                  child: Text('Reseñas', style: TextStyle(color: Colors.black),),
                                )
                              ],
                            ),
                          ])))
                    ],
                  ),
                  Divider(color: Colors.black,),
                  SizedBox(height: 150,),
                  Text('Espacio para mostrar platillos', style: TextStyle(fontSize: 20))
                ],
              )),
        ),
      ),
    );
  }
}
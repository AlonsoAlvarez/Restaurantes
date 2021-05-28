
import 'package:flutter/material.dart';
import 'package:restauranes/components/restaurant_detail/alert_create_review.dart';

import 'card_review.dart';
//import 'package:restauranes/models/review.dart';

class AlertReviews extends StatelessWidget {
  final List reviews;
  final String slugRestaurant;

  const AlertReviews({Key? key, required this.reviews, required this.slugRestaurant}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [ElevatedButton.icon(onPressed: () {
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return AlertCreateReview(slugRestaurant: slugRestaurant,);
        });
      }, icon: Icon(Icons.add), label: Text('Agregar reseña'))],
      title: Text('${reviews.length} Reseñas'),
      content: Container(
        height: 250,
        child: 0 < reviews.length?  ListView(
          children: [
            ...reviews.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: CardReview(review: e, key: ValueKey(e.slug),),
            ))
          ]
        ) : Center(child: Text('No hay reseñas aún')),
      ),
    );
  }
}

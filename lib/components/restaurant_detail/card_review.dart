import 'package:flutter/material.dart';
import 'package:restauranes/components/row_stars.dart';
import 'package:restauranes/models/review.dart';
import 'package:restauranes/utils/times.dart';

class CardReview extends StatelessWidget {
  final Review review;

  const CardReview({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide())
      ),
      child: Column(children: [
        RichText(
          text: TextSpan(
            text: '${review.email}: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: '${review.comments}',
                  style: DefaultTextStyle.of(context).style),
            ],
          ),
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            RowStars(rating: review.rating),
            Spacer(),
            Text('${Time.date(review.created)}', style: TextStyle(fontSize: 14),)
          ],
        ),
      ]),
    );
  }
}

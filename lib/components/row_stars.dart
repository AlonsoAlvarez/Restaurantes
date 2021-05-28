import 'package:flutter/material.dart';

class RowStars extends StatelessWidget {
  final num rating;

  const RowStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: 0 < rating ? Colors.yellow : Colors.grey[300],
        ),
        Icon(Icons.star,
            size: 15, color: 1 < rating ? Colors.yellow : Colors.grey[300]),
        Icon(Icons.star,
            size: 15, color: 2 < rating ? Colors.yellow : Colors.grey[300]),
        Icon(Icons.star,
            size: 15, color: 3 < rating ? Colors.yellow : Colors.grey[300]),
        Icon(Icons.star,
            size: 15, color: 4 < rating ? Colors.yellow : Colors.grey[300])
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restauranes/components/restaurants/card_restaurant.dart';
import 'package:restauranes/models/food_type.dart';
import 'package:restauranes/models/restaurant.dart';

class PageFoodTypeDetail extends StatelessWidget {
  final FoodType foodType;

  const PageFoodTypeDetail({Key? key, required this.foodType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comida ${foodType.name}'),
      ),
      body: FutureBuilder<List<Restaurant>?>(
          future: Restaurant.restaurantsFromFoodType(foodType.slug),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(child: Text('Ha ocurrido un error'));
            return 0 < snapshot.data!.length
                ? SingleChildScrollView(
                    child: Column(children: [
                      Text('Restaurantes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      Divider(
                        color: Colors.black,
                      ),
                      ...snapshot.data!.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: CardRestaurant(
                              restaurant: e,
                              key: ValueKey(e.slug),
                            ),
                          ))
                    ]),
                  )
                : Center(child: Text('No hay restaurantes aún'));
          }),
    );
  }
}

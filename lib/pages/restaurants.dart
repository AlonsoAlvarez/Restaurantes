import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauranes/components/restaurants/card_restaurant.dart';
import 'package:restauranes/models/food_type.dart';
import 'package:restauranes/models/restaurant.dart';

import 'create_restaurant.dart';
import 'food_type_detail.dart';

class PageRestaurants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text('Comidas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              Divider(
                color: Colors.black,
              ),
              FutureBuilder<List<FoodType>?>(
                  future: FoodType.getFoodTypes,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError)
                      return Center(child: Text('Ha ocurrido un error'));
                    return 0 < snapshot.data!.length
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              ...snapshot.data!.map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ElevatedButton(
                                        key: ValueKey(e.slug),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      PageFoodTypeDetail(
                                                        foodType: e,
                                                      )));
                                        },
                                        child: Text('${e.name}')),
                                  ))
                            ]),
                          )
                        : Center(child: Text('No hay tipos aún'));
                  }),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Spacer(),
                  Text('Restaurantes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageCreateRestaurant()));
                      },
                      icon: Icon(Icons.add)),
                  Spacer()
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              FutureBuilder<List<Restaurant>?>(
                  future: Restaurant.getRestaurants,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError)
                      return Center(child: Text('Ha ocurrido un error'));
                    return 0 < snapshot.data!.length
                        ? Column(children: [
                            ...snapshot.data!.map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: CardRestaurant(
                                    restaurant: e,
                                    key: ValueKey(e.slug),
                                  ),
                                ))
                          ])
                        : Center(child: Text('No hay restaurantes aún'));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restauranes/models/food_type.dart';

class AlertFoodTypes extends StatelessWidget {
  final Function function;

  const AlertFoodTypes({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tipos de comida'),
      content: Container(
        height: 250,
        child: FutureBuilder<List<FoodType>?>(
            future: FoodType.getFoodTypes,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError)
                return Center(child: Text('Ha ocurrido un error'));
              return 0 < snapshot.data!.length
                        ? ListView(children: [
                          ...snapshot.data!.map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5),
                                child: ElevatedButton(
                                    key: ValueKey(e.slug),
                                    style: ElevatedButton.styleFrom(primary: Colors.white),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      function(e);
                                    },
                                    child: Text('${e.name}', style: TextStyle(color: Colors.black),)),
                              ))
                        ])
                        : Center(child: Text('No hay tipos aún'));
            }),
      ),
    );
  }
}

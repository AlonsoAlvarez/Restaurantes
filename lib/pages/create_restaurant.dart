import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restauranes/components/create_restaurant/alert_food_types.dart';
import 'package:restauranes/components/create_restaurant/alert_pick_image.dart';
import 'package:restauranes/models/food_type.dart';
import 'package:restauranes/models/restaurant.dart';
import 'package:restauranes/pages/restaurants.dart';
import 'package:restauranes/utils/images.dart';

class PageCreateRestaurant extends StatefulWidget {
  @override
  _PageCreateRestaurantState createState() => _PageCreateRestaurantState();
}

class _PageCreateRestaurantState extends State<PageCreateRestaurant> {
  final _ctrlName = TextEditingController();
  final _ctrlDescription = TextEditingController();
  final _nodeDescription = FocusNode();
  final _formKey = GlobalKey<FormState>();

  List<FoodType> foodType = [];
  File fileImage = File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear restaurant'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PageRestaurants()));
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0)),
                    onPressed: () async {
                      if (fileImage.path != '') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertPickImage(
                                pick: () async {
                                  fileImage = await Images.pickedFile(ImageSource.gallery);
                                  setState(() {});
                                },
                                crop: () async {
                                  fileImage = await Images.cropImage(fileImage);
                                  setState(() {});
                                },
                                delete: () => setState(() => fileImage =
                                    File('')),
                                fileImage: fileImage,
                              );
                            });
                      } else {
                        // SELECCIONAR IMAGEN
                        fileImage =
                            await Images.pickedFile(ImageSource.gallery);
                        setState(() {});
                      }
                    },
                    child: Container(
                        color: Colors.white,
                        height: 150,
                        child: fileImage.path != ''
                            ? Image.file(fileImage)
                            : Image.asset('assets/restaurant_fade.jpg')),
                  ),
                ),
                TextFormField(
                  controller: _ctrlName,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_nodeDescription),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Agrega un nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ctrlDescription,
                  focusNode: _nodeDescription,
                  decoration: InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Agrega una descripción';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertFoodTypes(function: (type) {
                                    setState(() => foodType.add(type));
                                  });
                                });
                          },
                          child: Text(
                            'Agregar tipo de comida',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Seleccionados'),
                                    content: Container(
                                      height: 250,
                                      child: ListView(
                                        children: [
                                          ...foodType
                                              .map((e) => Text('${e.name}'))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            'Ver Seleccion',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                              0 < foodType.length &&
                              fileImage.path != ''
                          ) {
                        Restaurant.createRestaurant(_ctrlName.text,
                            _ctrlDescription.text, fileImage, foodType);
                      } else {
                        Fluttertoast.showToast(msg: 'Datos incompletos');
                      }
                    },
                    child: Text('Guardar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

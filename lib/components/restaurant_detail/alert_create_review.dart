import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauranes/models/review.dart';
import 'package:restauranes/pages/restaurants.dart';

class AlertCreateReview extends StatelessWidget {
  final String slugRestaurant;

  AlertCreateReview({Key? key, required this.slugRestaurant}) : super(key: key);

  final _ctrlEmail = TextEditingController();
  final _ctrlComments = TextEditingController();
  final _ctrlRating = TextEditingController();
  final _nodeComments = FocusNode();
  final _nodeRatting = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Crear reseña'),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => PageRestaurants(),
                  ),
                );
                Review.createReview(slugRestaurant, _ctrlEmail.text,
                    _ctrlComments.text, int.parse(_ctrlRating.text));
              } else {
                Fluttertoast.showToast(msg: 'Datos incompletos');
              }
            },
            child: Text('Guardar'))
      ],
      content: Container(
        height: 300,
        child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _ctrlEmail,
                decoration: InputDecoration(labelText: 'Email'),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_nodeComments),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Agrega una email';
                  }
                  if (value.contains('@') && value.contains('.')) {
                    return null;
                  } else {
                    return 'Email no valido';
                  }
                },
              ),
              TextFormField(
                controller: _ctrlComments,
                focusNode: _nodeComments,
                decoration: InputDecoration(labelText: 'Comentarios'),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_nodeRatting),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Agrega un tus comentarios';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ctrlRating,
                focusNode: _nodeRatting,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Rating'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Agrega una Rating';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Agrega un numero valido';
                  } else {
                    if (0 <= int.tryParse(value)! &&
                        int.tryParse(value)! <= 5) {
                      return null;
                    }
                    return 'Solo numeros entre 0 y 5';
                  }
                },
              ),
            ])),
      ),
    );
  }
}

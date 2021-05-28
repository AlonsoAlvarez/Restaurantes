import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String place;
  final String def;
  final String hero;

  const ShowImage({Key? key, required this.place, required this.def, required this.hero}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text('Regresar')),
      body: Center(
        child: Hero(
          tag: hero,
          child: Container(
            color: Colors.black,
            child: FadeInImage(
                placeholder: AssetImage(place),
                image: NetworkImage(def),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';

class AlertPickImage extends StatelessWidget {
  final Function pick;
  final Function crop;
  final Function delete;
  final File fileImage;

  const AlertPickImage({
    Key? key,
    required this.pick,
    required this.crop,
    required this.delete,
    required this.fileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Acciones',
      ),
      content: Container(
          height: 208,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: 150,
                    color: Colors.white,
                    child: FadeInImage(
                      image: FileImage(fileImage),
                      placeholder: AssetImage('assets/camara.png'),
                    )),
              ),
              SizedBox(height: 10),
              Row(children: [
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pick();
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.blueGrey,
                  ),
                )),
                SizedBox(width: 5),
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    crop();
                  },
                  icon: Icon(Icons.crop, color: Colors.orangeAccent),
                )),
                SizedBox(width: 5),
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    delete();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                )),
              ]),
            ],
          )),
    );
  }
}

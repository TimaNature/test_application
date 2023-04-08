import 'package:flutter/material.dart';

import '../repository/Repository.dart';
import 'image_list.dart';

class FullImage extends StatefulWidget {
  const FullImage({Key? key}) : super(key: key);

  @override
  FullImageState createState() => FullImageState();
}

class FullImageState extends State<FullImage> {
  String image = Repository().getImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              deleteImage();
            },
            child: const Text('Удалить картинку')),
      ])),
      body: Center(child: Image.network(image)),
    );
  }

  deleteImage() async {
    await Repository().deleteImage();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const ImageList()));
  }
}
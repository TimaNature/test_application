import 'package:flutter/material.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список картинок'),
      ),);
  }
}
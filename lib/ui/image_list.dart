import 'package:flutter/material.dart';
import 'package:test_application/main.dart';
import 'package:test_application/repository/Repository.dart';

import 'full_image.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {
  List<String> imageList = Repository().getImageList();

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
                resetRegistration();
              },
              child: const Text('Выйти из профиля')),
        ]),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: Border.all(
                width: 5,
              ),
              elevation: 20,
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Image.network(imageList[index]),
                    onTap: () => goToFullScreen(index),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: imageList.length,
      ),
    );
  }

  resetRegistration() async {
    await Repository().resetRegistration();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
  }

  goToFullScreen(int index) {
    Repository().setImageIndex(index);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const FullImage()));
  }
}

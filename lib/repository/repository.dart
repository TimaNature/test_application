import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static Repository? _instance;
  static const String _registration = "smsKey";
  static const String _images = "images";
  List<String> _imageList = [
    "https://picsum.photos/id/129/4910/3252",
    "https://picsum.photos/id/144/4912/2760",
    "https://picsum.photos/id/130/3807/2538",
    "https://picsum.photos/id/131/4698/3166",
    "https://picsum.photos/id/132/1600/1066",
    "https://picsum.photos/id/133/2742/1828",
    "https://picsum.photos/id/134/4928/3264",
    "https://picsum.photos/id/135/2560/1920"
  ];
  late SharedPreferences _preferences;
  int _imageIndex = 0;

  Repository._();

  factory Repository() {
    _instance ??= Repository._();
    return _instance!;
  }

  init() async {
    _preferences = await SharedPreferences.getInstance();
    _imageList = _preferences.getStringList(_images) ?? _imageList;
  }

  setImageIndex(int index) {
    _imageIndex = index;
  }

  setRegistration() async {
    _preferences.setBool(_registration, true);
  }

  resetRegistration() async {
    _preferences.clear();
  }

  String getImage() {
    return _imageList[_imageIndex];
  }

  List<String> getImageList() {
    return _imageList;
  }

  deleteImage() async {
    _imageList.removeAt(_imageIndex);
    await _preferences.setStringList(_images, _imageList);
  }

  Future<bool> isRegistered() async {
    await init();
    return _preferences.getBool(_registration) ?? false;
  }
}

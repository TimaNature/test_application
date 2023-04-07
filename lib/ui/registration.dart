import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'confirm_sms.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {
  final _phoneController = TextEditingController();
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Регистрация'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Введите номер телефона для регистрации'),
                )),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showProgress = true;
                });

                Timer(const Duration(seconds: 2), () => sendPhone());
              },
              child: const Text('Запросить смс'),
            ),
            if (showProgress) const CircularProgressIndicator()
          ],
        ));
  }

  sendPhone() {
    if (_phoneController.text.contains("79998887766")) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const Confirm()));
    } else {
      setState(() {
        showProgress = false;
      });

      Alert(
        context: context,
        type: AlertType.info,
        title: "На данный номер выслать СМС невозможно",
        desc: "Номер телефона должен быть из нашей базы данных",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: const Text(
              "Ок",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

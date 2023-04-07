import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:test_application/ui/image_list.dart';

class Confirm extends StatefulWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  ConfirmState createState() => ConfirmState();
}

class ConfirmState extends State<Confirm> {
  final _confirmController = TextEditingController();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  bool showResendSms = false;
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
                  controller: _confirmController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Введите код из СМС'),
                )),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showProgress = true;
                });

                Timer(const Duration(seconds: 2), () => sendSms());
              },
              child: const Text('Зарегестрироваться'),
            ),
            if (showResendSms) ...[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {
                  resendSms();
                },
                child: const Text('Отправить код повторно'),
              )
            ] else ...[
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      const Text(
                          "Повтроно отправить код на телефон можно через"),
                      CountdownTimer(
                        endTime: endTime,
                        onEnd: onEnd,
                      ),
                    ],
                  )),
            ],
            if (showProgress) const CircularProgressIndicator()
          ],
        ));
  }

  void onEnd() {
    setState(() {
      showResendSms = true;
    });
  }

  void resendSms() {
    setState(() {
      showProgress = true;
    });

    Timer(
        const Duration(seconds: 2),
        () => {
              setState(() {
                showProgress = false;
                endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
                showResendSms = false;
              })
            });
  }

  void sendSms() {
    if (_confirmController.text == "1111") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const ImageList()));
    } else {
      setState(() {
        showProgress = false;
      });

      Alert(
        context: context,
        type: AlertType.info,
        title: "Код неверный",
        desc: "Проверьте пожалуйста код, присланный вам в смс",
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
    _confirmController.dispose();
    super.dispose();
  }
}

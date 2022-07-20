import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  final _num = 0.obs;
  get num => this._num.value;
  set num(value) => this._num.value = value;

  increment() {
    this.num++;
  }

  decrement() {
    this.num--;
  }
}

class StudyFlutter extends GetWidget {
  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    log('Build Study');
    return Scaffold(
        appBar: AppBar(
          title: Text('Estudo Flutter'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GetX<MyController>(
              builder: (_) => Text(
                _.num.toString(),
                style: TextStyle(fontSize: 60),
              ),
            ),
            Container(
              height: 300,
              width: 345,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () => controller.increment(),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                    onPressed: () => {controller.decrement()},
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

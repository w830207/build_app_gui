import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'build_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("請輸入專案目錄地址"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("如：/Users/wangchenbo/StudioProjects/lilian_yabo"),
            TextField(controller: myController),
            OutlinedButton(
              child: const Text('去打包'),
              onPressed: () {
                Get.to(() => BuildPage(
                      app_dir: myController.text,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

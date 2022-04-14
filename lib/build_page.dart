import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'build_controller.dart';

class BuildPage extends StatelessWidget {
  BuildPage({Key? key, required this.appDir, required this.env})
      : super(key: key);
  final String appDir;
  final String env;
  final TextEditingController myController = TextEditingController();
  final BuildController controller = Get.put(BuildController());
  RxString show = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("打包"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Obx(() {
                  return Text(controller.showingLog.value);
                }),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      debugPrint('statement');
                    },
                    child: const Text('debugPrint')),
                TextButton(
                    onPressed: () {
                      controller.translate(appDir);
                    },
                    child: const Text("點擊翻譯")),
                TextButton(
                    onPressed: () => controller.makeApkKey(appDir),
                    child: const Text("建立apk key")),
                const Divider(),
                TextButton(
                    onPressed: () => controller.bothMakeAll(appDir, env),
                    child: const Text("雙平台全渠道打包")),
                const Divider(),
                //選擇平台
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text("Android"),
                          Checkbox(
                            value: controller.isAndroid.value,
                            onChanged: (isTapedAndroid) {
                              controller.tapAndroid(isTapedAndroid!);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: <Widget>[
                          const Text("IOS"),
                          Checkbox(
                            value: controller.isIOS.value,
                            onChanged: (isTapedIOS) {
                              controller.tapIOS(isTapedIOS!);
                            },
                          )
                        ],
                      ),
                    ],
                  );
                }),
                TextButton(
                    onPressed: () => controller.singleMakeAll(appDir, env),
                    child: const Text("單平台全渠道打包")),

                //輸入渠道
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(hintText: '輸入a-z其中一個'),
                  ),
                ),
                TextButton(
                    onPressed: () => controller.singleMakeOne(
                        appDir, myController.text, env),
                    child: const Text("單平台輸入渠道打包"))
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

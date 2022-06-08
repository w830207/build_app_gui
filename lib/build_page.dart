import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'build_controller.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key, required this.appDir, required this.env})
      : super(key: key);
  final String appDir;
  final String env;

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  final TextEditingController myController = TextEditingController();

  final TextEditingController specialController = TextEditingController();

  final BuildController controller = Get.put(BuildController());

  RxString show = "".obs;

  String channelValue = "a";

  String specialChannelValue = "tt5885t";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.env}打包"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
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
                    onPressed: () => controller.makeApkKey(widget.appDir),
                    child: const Text("0.建立apk key")),
                TextButton(
                    onPressed: () {
                      controller.translate(widget.appDir);
                    },
                    child: const Text("1.點擊翻譯")),

                // const Divider(),
                // TextButton(
                //     onPressed: () => controller.bothMakeAll(appDir, env),
                //     child: const Text("雙平台全渠道打包")),
                const Divider(),
                const Text("2.選擇打包平台"),
                //選擇平台
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text("AndroidV1"),
                          Checkbox(
                            value: controller.isAndroidV1.value,
                            onChanged: (isTapedAndroid) {
                              controller.tapAndroidV1(isTapedAndroid!);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: <Widget>[
                          const Text("AndroidV2"),
                          Checkbox(
                            value: controller.isAndroidV2.value,
                            onChanged: (isTapedAndroid) {
                              controller.tapAndroidV2(isTapedAndroid!);
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
                const Divider(),
                const Text("3.選擇打包渠道進行打包"),
                TextButton(
                  onPressed: () =>
                      controller.singleMakeAll(widget.appDir, widget.env),
                  child: const Text("全一般渠道打包"),
                ),

                Row(
                  children: [
                    DropdownButton(
                      value: channelValue,
                      onChanged: (String? selectValue) {
                        setState(() {
                          channelValue = selectValue!;
                        });
                      },
                      items: controller
                          .pickAlphabetList(widget.env)
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    TextButton(
                      onPressed: () => controller.singleMakeOne(
                          widget.appDir, channelValue, widget.env),
                      child: const Text("選擇指定渠道打包"),
                    ),
                  ],
                ),
                //輸入渠道
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: myController,
                        decoration: const InputDecoration(
                            hintText: '如：輸入orz，打包02399orz渠道'),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.singleMakeOne(
                          widget.appDir, myController.text, widget.env),
                      child: const Text("輸入指定渠道打包"),
                    ),
                  ],
                ),
                const Divider(),
                TextButton(
                  onPressed: () => controller.singleMakeSpecialAll(
                      widget.appDir, widget.env),
                  child: const Text("全特殊渠道打包"),
                ),

                Row(
                  children: [
                    DropdownButton(
                      value: specialChannelValue,
                      onChanged: (String? selectValue) {
                        setState(() {
                          specialChannelValue = selectValue!;
                        });
                      },
                      items: controller.specialChannel
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    TextButton(
                      onPressed: () => controller.singleMakeOne(
                          widget.appDir, specialChannelValue, widget.env),
                      child: const Text("選擇特殊渠道打包"),
                    ),
                  ],
                ),
                //輸入渠道
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: specialController,
                        decoration: const InputDecoration(
                            hintText: '輸入特殊渠道全名如 k6415c '),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.singleMakeSpecialOne(
                          widget.appDir, specialController.text, widget.env),
                      child: const Text("輸入特殊渠道打包"),
                    ),
                  ],
                ),

                const Divider(),
                const Text("4.Terminal/CMD/終端機 APK手動上傳"),
                TextButton(
                    onPressed: () =>
                        controller.copyCommend(widget.appDir, widget.env),
                    child: const Text("複製命令")),
                TextButton(
                    onPressed: () =>
                        controller.copyPassword(widget.appDir, widget.env),
                    child: const Text("複製密碼")),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

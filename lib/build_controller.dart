import 'package:get/get.dart';
import 'package:process_run/shell.dart';

class BuildController extends GetxController {
  RxBool isAndroid = true.obs;
  RxBool isIOS = false.obs;
  RxString showingLog = "".obs;
  late Shell shell;

  final List alphabet = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ];

  @override
  void onInit() {
    super.onInit();
    shell = Shell();
  }

  tapAndroid(bool isTaped) {
    if (isTaped) {
      isAndroid.value = true;
      isIOS.value = false;
    }
  }

  tapIOS(bool isTaped) {
    if (isTaped) {
      isIOS.value = true;
      isAndroid.value = false;
    }
  }

  ///翻譯
  translate(String appDir) async {
    showingLog.value = "";
    shell = Shell(workingDirectory: appDir);
    showingLog.value += "打開translation\n";
    shell = shell.pushd('translation');

    showingLog.value += "安裝 npm...\n";
    await shell.run('npm install');

    showingLog.value += "翻譯轉換...\n";
    await shell.run('npm run convert');

    shell = shell.popd();

    showingLog.value += "搬移語系檔案\n";
    await shell.run('''
rm -rf ./lib/core/values/languages/from/zh_CN
mv ./translation/zh_CN ./lib/core/values/languages/from
echo "\033[0;32m✔\033[0m 搬移語系檔案"
    ''');
    showingLog.value += "翻譯完成\n";
  }

  ///製作apk key
  makeApkKey(String appDir) async {
    showingLog.value = "";
    shell = Shell(workingDirectory: appDir + "/android");
    showingLog.value += "寫入APK金鑰...\n";
    await shell.run('''
echo "c3RvcmVQYXNzd29yZD1xd3F3MTIxMgprZXlQYXNzd29yZD1xd3F3MTIxMgprZXlBbGlhcz1rZXkKc3RvcmVGaWxlPWtleS5qa3MK" | base64 --decode > key.properties
echo "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" | base64 --decode > key.jks
echo "\033[0;32m✔\033[0m 寫入APK金鑰"
    ''');
    showingLog.value += "APK KEY完成\n";
  }

  ///ipa 和 apk 全渠道打包
  bothMakeAll(String appDir, String env) async {
    showingLog.value = "";
    shell = Shell(workingDirectory: appDir);

    String folder = env.toLowerCase();

    for (var i in alphabet) {
      //打包
      showingLog.value += "打包渠道$i APK v1v2...\n";
      await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --flavor=v1 --release 
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
flutter build apk --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --release
echo "\033[0;32m✔\033[0m IPA build Success"
    ''');
      showingLog.value += "APKv1v2打包成功\n";
      showingLog.value += "打包渠道$i IOS...\n";
      await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --release
echo "\033[0;32m✔\033[0m IPA build Success"
    ''');
      showingLog.value += "IOS打包成功\n";

      showingLog.value += "製做ipa\n";
      //製成ipa
      shell = shell.pushd("build/ios/iphoneos");
      await shell.run('''
rm -rf Payload
rm -rf Payload.ipa
mkdir Payload
    ''');
      shell = shell.pushd("Payload");
      await shell.run('ln -s ../Runner.app');
      shell = shell.popd();
      await shell.run('''
zip -r Payload.ipa Payload
echo "\033[0;32m✔\033[0m 生成IPA"
      ''');
      showingLog.value += "IPA製作完成\n";
      shell = shell.popd();

      //搬移檔案
      showingLog.value += "渠道$i搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/$i
    ''');
      shell = shell.pushd("publish/outputs/$folder/$i");
      await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./app-release.apk
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./app-release-v2.apk
mv $appDir/build/ios/iphoneos/Payload.ipa ./Payload.ipa
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
    }
    showingLog.value += "打包完成\n";
  }

  ///單平台 全渠道打包
  singleMakeAll(String appDir, String env) async {
    showingLog.value = "";
    shell = Shell(
      workingDirectory: appDir,
      throwOnError: false,
    );

    String folder = env.toLowerCase();

    if (isAndroid.value) {
      for (var i in alphabet) {
        //打包
        showingLog.value += "打包渠道$i APK v1v2...\n";
        await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --flavor=v1 --release 
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
flutter build apk --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
    ''');
        showingLog.value += "APKv1v2打包成功\n";

        //搬移檔案
        showingLog.value += "搬移檔案\n";
        await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/$i
    ''');
        shell = shell.pushd("publish/outputs/$folder/$i");
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./app-release.apk
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./app-release-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
      }
    }

    if (isIOS.value) {
      for (var i in alphabet) {
        //打包
        showingLog.value += "打包渠道$i IOS...\n";
        await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --release
echo "\033[0;32m✔\033[0m IPA build Success"
    ''');
        showingLog.value += "IOS打包成功\n";

        //製成ipa
        showingLog.value += "製作ipa\n";
        shell = shell.pushd("build/ios/iphoneos");
        await shell.run('''
rm -rf Payload
rm -rf Payload.ipa
mkdir Payload
    ''');
        shell = shell.pushd("Payload");
        await shell.run('ln -s ../Runner.app');
        shell = shell.popd();
        await shell.run('''
zip -r Payload.ipa Payload
echo "\033[0;32m✔\033[0m 生成IPA"
      ''');
        shell = shell.popd();
        showingLog.value += "ipa製作完成\n";

        //搬移檔案
        showingLog.value += "渠道$i搬移檔案\n";
        await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/$i
    ''');
        shell = shell.pushd("publish/outputs/$folder/$i");
        await shell.run('''
mv ${appDir}/build/ios/iphoneos/Payload.ipa ./Payload.ipa
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
      }
    }

    showingLog.value += "打包完成\n";
  }

  ///單平台 指定渠道打包
  singleMakeOne(String appDir, String i, String env) async {
    showingLog.value = "";
    shell = Shell(
      workingDirectory: appDir,
      throwOnError: false,
    );

    String folder = env.toLowerCase();

    if (isAndroid.value) {
      //打包
      showingLog.value += "打包渠道$i APK v1v2...\n";
      await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --flavor=v1 --release 
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
flutter build apk --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
    ''');
      showingLog.value += "APKv1v2打包成功\n";

      //搬移檔案
      showingLog.value += "搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/$i
    ''');
      shell = shell.pushd("publish/outputs/$folder/$i");
      await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./app-release.apk
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./app-release-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
    }

    if (isIOS.value) {
      //打包
      showingLog.value += "打包渠道$i IOS...\n";
      await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$env --dart-define=CHANNEL=02399$i --release
echo "\033[0;32m✔\033[0m IPA build Success"
    ''');
      showingLog.value += "IOS打包成功\n";

      //製成ipa
      showingLog.value += "製作ipa\n";
      shell = shell.pushd("build/ios/iphoneos");
      await shell.run('''
rm -rf Payload
rm -rf Payload.ipa
mkdir Payload
    ''');
      shell = shell.pushd("Payload");
      await shell.run('ln -s ../Runner.app');
      shell = shell.popd();
      await shell.run('''
zip -r Payload.ipa Payload
echo "\033[0;32m✔\033[0m 生成IPA"
      ''');
      shell = shell.popd();
      showingLog.value += "ipa製作完成\n";

      //搬移檔案
      showingLog.value += "搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/$i
    ''');
      shell = shell.pushd("publish/outputs/$folder/$i");
      await shell.run('''
mv $appDir/build/ios/iphoneos/Payload.ipa ./Payload.ipa
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
    }
    showingLog.value += "打包完成\n";
  }
}

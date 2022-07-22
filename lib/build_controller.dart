import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:process_run/shell.dart';
import 'package:flutter/services.dart';

class BuildController extends GetxController {
  RxBool isAndroidV1 = true.obs;
  RxBool isAndroidV2 = false.obs;
  RxBool isIOS = false.obs;
  RxString showingLog = "".obs;
  late Shell shell;

  List pickAlphabetList(String env) {
    if (env == "PROD") {
      return alphabetPROD;
    }
    return alphabetUAT;
  }

  final List alphabetUAT = [
    "a",
    "b",
    "main",
  ];

  final List alphabetPROD = [
    "main",
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
    "z",

    //0522新增
    "aa",
    "bb",
    "cc",
    "dd",
    "ee",
    "ff",
    "gg",
    "hh",
    "ii",
    "jj",
    "kk",
    "ll",
    "mm",
    "nn",
    "oo",

    //0523新增
    "pp",
    "qq",
    "rr",
    "ss",
    "tt",
    "uu",
    "vv",
    "ww",
    "xx",
    "yy",
    "zz",
    "ab",
    "ac",
    "ad",
    "ae",
    "af",
    "ag",
    "ah",
    "ai",
    "aj",
    "ak",
    "al",
    "am",
    "an",
    "ao",
    "ap",
    "aq",
    "ar",
    "as",
    "at",
    "au",
    "av",
    "aw",
    "ax",
    "ay",
  ];

  final List specialChannel = [
    "k6415c",
    "k6415n",
    "la3008c",
    "la3008n",
    "ya5274c",
    "a3037c",
    "a3037n",
    "b8046c",
    "b8046n",
    "f3189c",
    "f3189n",
    "fa3035c",
    "bo3035n",
    "al3661c",
    "al3661n",
    "as5269c",

    //新的
    "bxboon",
    "dkoktc",
    "kfcklgc",
    "mdnsuuc",
    "xoxopn",

    //0529
    "ax5678p",
    "ax5678e",
    "ax5678c",

    //0530
    "wp66088p",
    "ue5885e",
    "cc5885c",
    "xx5885x",
    "ni5885n",
    "em5885m",
    "tt5885t",

    //0616
    "99520v",
    "99220v",
    "99130v",
    "99150v",
    "99160v",
    "99180v",
    "99650v",
    "99690v",
    "99770v",
    "99660v",

    //0617
    "99100co",
    "99200co",
    "99300co",
    "99500co",
    "99770co",
    "99550co",
    "99900co",
    "12198cc",
    "12208cc",
    "12210cc",
    "12818cc",
    "12508cc",
    "12938cc",
    "12578cc",
    "12587cc",

    //0618
    "66100co",
    "66500co",
    "66700co",
    "66900co",
    "66087co",
    "66187co",
    "66387co",
    "66887co",
    "66099co",
    "66299co",

    //0715
    "aworkgceus",
    "bnetgfeus",
    "crouteus",
    "dprintgtus",
    "efightkous",
    "ashutopw",
    "bfallopw",
    "cplangopw",
    "dmainxpw",
    "edownwpw",

    //0716
    "500120cz",
    "500220cz",
    "500320cz",
    "500420cz",
    "500620cz",
    "500720cz",
  ];

  @override
  void onInit() {
    super.onInit();
    shell = Shell();
  }

  tapAndroidV1(bool isTaped) {
    if (isTaped) {
      isAndroidV1.value = true;
      isAndroidV2.value = false;
      isIOS.value = false;
    }
  }

  tapAndroidV2(bool isTaped) {
    if (isTaped) {
      isAndroidV2.value = true;
      isAndroidV1.value = false;
      isIOS.value = false;
    }
  }

  tapIOS(bool isTaped) {
    if (isTaped) {
      isIOS.value = true;
      isAndroidV1.value = false;
      isAndroidV2.value = false;
    }
  }

  // ///上傳apk
  // uploadAPK(String appDir) async {
  //   showingLog.value = "";
  //   String password = 'MCv@\!0Xd86\$g';
  //   shell = Shell(workingDirectory: appDir);
  //   shell.run(
  //       'scp -P 55160 ./publish/outputs/uat/0/*.apk arduser@172.31.32.91:/home/lili_promote/storage/app/apk');
  // }

  copyCommend(String appDir, String env) {
    if (env == "PROD") {
      Clipboard.setData(ClipboardData(
          text:
              'scp -P 55160 $appDir/publish/outputs/prod/0/*.apk arduser@192.168.30.200:/home/ant_promote/storage/app/apk'));
    } else {
      Clipboard.setData(ClipboardData(
          text:
              "scp -P 55160 $appDir/publish/outputs/uat/0/*.apk arduser@172.31.32.91:/home/lili_promote/storage/app/apk"));
    }
  }

  copyPassword(String appDir, String env) {
    if (env == "PROD") {
      Clipboard.setData(const ClipboardData(text: 'OvO@0!0Pk1*9'));
    } else {
      Clipboard.setData(const ClipboardData(text: "MCv@!0Xd86\$g"));
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
  makeApkKey(String appDir, String env) async {
    showingLog.value = "";
    shell = Shell(workingDirectory: appDir + "/android");
    showingLog.value += "寫入APK金鑰...\n";

    String properties64 = "";
    String jks64 = "";

    if (env == "PROD") {
      properties64 =
          "c3RvcmVQYXNzd29yZD1nd1dEdUE0UHp5aXMKa2V5UGFzc3dvcmQ9RWVhOENXSUlSOWxqCmtleUFsaWFzPWFudF9saWxpYW4Kc3RvcmVGaWxlPWFudF9saWxpYW4uamtzCg==";
      jks64 =
          "/u3+7QAAAAIAAAABAAAAAQAKYW50X2xpbGlhbgAAAX4zDYcUAAAFAjCCBP4wDgYKKwYBBAEqAhEBAQUABIIE6k0Gd/SCc6sA3CsMQDNavq+hBYHvDalxCZl8yGhQ+QzUcqiWEARQeW8hGSw09z59TSQpfAIifQtUKnNizUZwTg/WmIQDHM7heN3GhQSMvxZirqWuRkLNctOSUPaIBNSs0sNIFjwkH8XjgLYPWBdj1UMpEk1mKPSwWMHmQDUwvoEyHXBgQN+G0Nff9hfPi2kh0ESBMlsGA9x6bAKK2/Thk1IFnswOXuQcQWgg7vMFzW6maXSAuTOfgEmv19DawDXhHHyl62zo81L5rAx/EOlTygcwBYbeKCiswjkJF2gDvrrFMkCgbP1EBrL6EYTD5sHgwRjM0OhNu+HfpTPXWet8YUDjOfWh0Q128kMQJC5BVL5TB95eNKPdpYeZsr/ynKj1mdHFyVVobgb0Gm4SBQmq7MVAd9LAhPk9wmNZiY9Xon1zavRxe7x4cvLseF3lWowjvpkqNNxeCgt+1kxIAgxBnZU2x0Tf7KVm7E/3vuPEXqAgfxgomlfn4geij/Gp72fUQOBop5S+fE8CrMkbbkpAAIFjqGUphafXxqmAOkcLTuC7CGvSkNcG1pY+2nR8l+3dERUI/yDiOEYUW0Ax8k294dz0i6IImsEPOrXnLvR1AUUYLmHG8qhnVpeoggKXTODFKd6iBsBBGBUCGvNIbkOylC8ZD5ONTfIiiWFPFQMgKfIqP855hfo4s9VsfYRGD82MBFeIlN0vkpT0QWzZYY6l+SgUve2HxXhTc19n0ef8CCgZhRXHHUaubOFh1AZZwd1bG6ikvduxTUYRXpEtOaLqhzHspaXjlcuBEWuXlaDLd2glxnG+YAT1YEpaEF0JizvQgC7tdVEGPtcGFBIr/ePuhLq08bs5Tl2hQgqa7NfU6vGmCjgQM26VVk6NNt37vbXCM426dLRkLQdbjvIFdLh+DSJXOt8Zzm4LYue1MjLIjTQxZxVIAr8iRezr2BZre8cM5Umkp6GZf97aUbJKe8f3HeRPD69HxdvW5kNJO3K3cnO9l92IwlqpJYPJAoeHOkaiXZ3lphtrs3r8Yx4SwMkrtQVcLJhFr/+j7s4+Y9UoKTGWEhClEUnUWOsXt4rCmWM670tYl4vUru4/RYeTkm+1Kr9djN9mrYuCB2j5MQYG+UCY+4H5Uk1F3ye5wqJd4SKcyl+6y2Q/rXKwi/AWG98Kj1/s5YcTyQPHP4HxHkB6Tr3iIwEQkykD/hkOC01bWs0iMBfIP8iXUd2DJaX83J9Ola2blayiWW+e45/+ULhPGB8Va5P0xqOY1rcuvmkkn3X/HNHuCsq+RtYS2Y26fE8x6hvuuINKlTmp51YMAkPpuIjGs4WgBKLIm9g7we6PwaOvRxa5AttTM4eOWRwT6RtO14q/jZ+FS0G7NV1Z6T7T8b/6Dl25hYfVA73nDJrhlJHvoGOi33ianMvWDVMlyg8p9/6f0qqcx4U2MV6jp7YWyuKzAN1+m+t0NHV0sJ5PdF+FiZJ7k2safteJruy+GcWmt8np+g3KqoPVE7OXJGIYeQ3qfSu47MsIZl+5Pv0WDF0Pf2Q73gAyBCZ/QabWEFO1S3CFIzMSs6gGcJEfRtkEp2OITU4UPvurBYp6oIQhk6S1C4fFcXA7eCB9/k6U8C9W1Gk3H6e6CXXLFav42d6gjFMFmeTaNGci5td6EWWuQPQlnaps26E0Yf6Nnl4AAAABAAVYLjUwOQAAA3swggN3MIICX6ADAgECAgQ2Rd2lMA0GCSqGSIb3DQEBCwUAMGwxEDAOBgNVBAYTB1Vua25vd24xEDAOBgNVBAgTB1Vua25vd24xEDAOBgNVBAcTB1Vua25vd24xEDAOBgNVBAoTB1Vua25vd24xEDAOBgNVBAsTB1Vua25vd24xEDAOBgNVBAMTB1Vua25vd24wHhcNMjIwMTA3MDU0MDE1WhcNNDkwNTI1MDU0MDE1WjBsMRAwDgYDVQQGEwdVbmtub3duMRAwDgYDVQQIEwdVbmtub3duMRAwDgYDVQQHEwdVbmtub3duMRAwDgYDVQQKEwdVbmtub3duMRAwDgYDVQQLEwdVbmtub3duMRAwDgYDVQQDEwdVbmtub3duMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiHoNh++CdZiOkAxtUNJKo+Dj+X8uSGnL9dDRNM5LhvEbH1gdUFekdfs4ETjTe7lU8GgfRBpvpSs9RiG2UY32f7/h8iiHvtyvuGKl0wYgS5tnEAIPzgjmMs+psZqMuR6ZbNur0WG5czWilp7vtNzaC6j4+bAUbLT7NK94Aplm4tWdlXvgC8jjNFE36f+FJfSORVs9X9WZIRR378mbkVb8eD0o4m2pWn2nrax3QVBktVb4usM+ulr0hNiJnq67OlW66fuxj2mTKKhh1vW5pMpdFt7qtgYOAIcK5Bo9hNNh/XP2PUhNK9bomNFWPHmC5m0FjOLSW9eKUDo0Eo0Y7qoN+wIDAQABoyEwHzAdBgNVHQ4EFgQUYjVEw14uSoQD6AL8oJdbJd3jDRowDQYJKoZIhvcNAQELBQADggEBACgWciOYRlU7hNsu555oFlxIgr8haSbFpvnIurxZi8Hhay6jmWs5vOZD/VWsqpJo51g0r3wOgLHeMk/MaoxoxkMXACdK0hvDxOqyKAdGQkMTu4GvXW4s12kAtoWy+z7p8miFHjTRWQxN8eYxeKMD2WK7jpwcDAsck/ocExx48rfal2oPZdjToo1zCqtHAicMekWKVGJRjjN8B3Zb88V81W8lP/n/ERvpTxID3YAO7YRHCzenlCYW79+g9OiJb4zO5CGlkZKHMUPw9MQGmkWpTw+Z9LmiFGUpdHQfnlOzRnV8on6N99Qk02WDMpAY3c9pzxixc9ZrhF9FnTIbfmIcpPaMDnd40B/bFGhGx36hpllwKwf1dA==";
    } else {
      properties64 =
          "c3RvcmVQYXNzd29yZD1xd3F3MTIxMgprZXlQYXNzd29yZD1xd3F3MTIxMgprZXlBbGlhcz1rZXkKc3RvcmVGaWxlPWtleS5qa3MK";
      jks64 =
          "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";
    }

    Uint8List propertiesBytes = base64.decode(properties64);
    Uint8List jksBytes = base64.decode(jks64);

    File properties = File("$appDir/android/key.properties");
    late File jks;

    if (env == "PROD") {
      jks = File("$appDir/android/ant_lilian.jks");
    } else {
      jks = File("$appDir/android/key.jks");
    }

    await properties.writeAsBytes(propertiesBytes);
    await jks.writeAsBytes(jksBytes);

    showingLog.value += "APK KEY完成\n";
  }

//   ///ipa 和 v2 apk 全渠道打包
//   bothMakeAll(String appDir, String env) async {
//     showingLog.value = "";
//
//     String folder = env.toLowerCase();
//     String ENV = env == "PROD" ? "PROD" : "DEV";
//
//     List alphabet = env == "PROD" ? alphabetPROD : alphabetUAT;
//
//     for (var i in alphabet) {
//       shell = Shell(workingDirectory: appDir);
//
//       //打包
//       showingLog.value += "打包渠道$i APK v2...\n";
//       await shell.run('''
// flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --flavor=v2 --release
// echo "\033[0;32m✔\033[0m APK v2 shema build Success"
//     ''');
//       showingLog.value += "APKv2打包成功\n";
//       showingLog.value += "打包渠道$i IOS...\n";
//       await shell.run('''
// flutter build ios --no-codesign --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --release
// echo "\033[0;32m✔\033[0m IPA build Success"
//     ''');
//       showingLog.value += "IOS打包成功\n";
//
//       showingLog.value += "製做ipa\n";
//       //製成ipa
//       shell = shell.pushd("build/ios/iphoneos");
//       await shell.run('''
// rm -rf Payload
// rm -rf Payload.ipa
// mkdir Payload
//     ''');
//       shell = shell.pushd("Payload");
//       await shell.run('ln -s ../Runner.app');
//       shell = shell.popd();
//       await shell.run('''
// zip -r Payload.ipa Payload
// echo "\033[0;32m✔\033[0m 生成IPA"
//       ''');
//       showingLog.value += "IPA製作完成\n";
//       shell = shell.popd();
//
//       //搬移檔案
//       showingLog.value += "渠道$i搬移檔案\n";
//       await shell.run('''
// mkdir -p $appDir/publish
// mkdir -p $appDir/publish/outputs
// mkdir -p $appDir/publish/outputs/$folder
// mkdir -p $appDir/publish/outputs/$folder/$i
//     ''');
//       shell = shell.pushd("publish/outputs/$folder/$i");
//       await shell.run('''
// mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./02399$i-v2.apk
// mv $appDir/build/ios/iphoneos/Payload.ipa ./Payload.ipa
// echo "\033[0;32m✔\033[0m 檔案搬移"
//     ''');
//       showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
//     }
//     showingLog.value += "打包完成\n";
//   }

  ///單平台 全渠道打包
  singleMakeAll(String appDir, String env) async {
    showingLog.value = "";

    String folder = env.toLowerCase();
    String ENV = env == "PROD" ? "PROD" : "DEV";

    List alphabet = env == "PROD" ? alphabetPROD : alphabetUAT;

    if (isAndroidV2.value) {
      for (var i in alphabet) {
        shell = Shell(workingDirectory: appDir);
        //打包
        showingLog.value += "打包渠道$i APK v2...\n";
        await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
    ''');
        showingLog.value += "APKv2打包成功\n";

        //搬移檔案
        showingLog.value += "搬移檔案\n";
        await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
        shell = shell.pushd("publish/outputs/$folder/0");

        if (i == "main") {
          await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./app-release-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        } else {
          await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./02399$i-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        }

        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
      }
    }

    if (isAndroidV1.value) {
      for (var i in alphabet) {
        shell = Shell(workingDirectory: appDir);
        //打包
        showingLog.value += "打包渠道$i APK v1...\n";
        await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --flavor=v1 --release
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
    ''');
        showingLog.value += "APKv1打包成功\n";

        //搬移檔案
        showingLog.value += "搬移檔案\n";
        await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
        shell = shell.pushd("publish/outputs/$folder/0");

        if (i == "main") {
          await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./app-release.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        } else {
          await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./02399$i.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        }

        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
      }
    }

    if (isIOS.value) {
      for (var i in alphabet) {
        shell = Shell(workingDirectory: appDir);
        //打包
        showingLog.value += "打包渠道$i IOS...\n";
        await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --release
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
mv $appDir/build/ios/iphoneos/Payload.ipa ./Payload.ipa
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
    shell = Shell(workingDirectory: appDir);

    String folder = env.toLowerCase();
    String ENV = env == "PROD" ? "PROD" : "DEV";

    if (isAndroidV2.value) {
      //打包
      showingLog.value += "打包渠道$i APK v2...\n";
      await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
    ''');
      showingLog.value += "APKv2打包成功\n";

      //搬移檔案
      showingLog.value += "搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
      shell = shell.pushd("publish/outputs/$folder/0");

      if (i == "main") {
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./app-release-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      } else {
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./02399$i-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      }

      showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
    }

    if (isAndroidV1.value) {
      //打包
      showingLog.value += "打包渠道$i APK v1...\n";
      await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --flavor=v1 --release
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
    ''');
      showingLog.value += "APKv1打包成功\n";

      //搬移檔案
      showingLog.value += "搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
      shell = shell.pushd("publish/outputs/$folder/0");
      if (i == "main") {
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./app-release.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      } else {
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./02399$i.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      }
      showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
    }

    if (isIOS.value) {
      //打包
      showingLog.value += "打包渠道$i IOS...\n";
      await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=02399$i --release
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

  ///單平台 指定特殊渠道打包
  singleMakeSpecialOne(String appDir, String name, String env) async {
    showingLog.value = "";
    shell = Shell(workingDirectory: appDir);

    String folder = env.toLowerCase();
    String ENV = env == "PROD" ? "PROD" : "DEV";

    if (isAndroidV2.value) {
      //打包
      showingLog.value += "打包渠道$name APK v2...\n";
      await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=$name --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
    ''');
      showingLog.value += "APKv2打包成功\n";

      //搬移檔案
      showingLog.value += "搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
      shell = shell.pushd("publish/outputs/$folder/0");
      await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./$name-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      showingLog.value += "渠道$name搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
    }

    if (isAndroidV1.value) {
      //打包
      showingLog.value += "打包渠道$name APK v1...\n";
      await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=$name --flavor=v1 --release
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
    ''');
      showingLog.value += "APKv1打包成功\n";

      //搬移檔案
      showingLog.value += "搬移檔案\n";
      await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
      shell = shell.pushd("publish/outputs/$folder/0");
      await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./$name.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      showingLog.value += "渠道$name搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
    }

    if (isIOS.value) {
      //打包
      showingLog.value += "打包渠道$name IOS...\n";
      await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=$name --release
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
mkdir -p $appDir/publish/outputs/$folder/$name
    ''');
      shell = shell.pushd("publish/outputs/$folder/$name");
      await shell.run('''
mv $appDir/build/ios/iphoneos/Payload.ipa ./Payload.ipa
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
      showingLog.value +=
          "渠道$name搬移檔案完成 $appDir/publish/outputs/$folder/$name\n";
    }
    showingLog.value += "打包完成\n";
  }

  ///單平台 特殊全渠道打包
  singleMakeSpecialAll(String appDir, String env) async {
    showingLog.value = "";

    String folder = env.toLowerCase();
    String ENV = env == "PROD" ? "PROD" : "DEV";

    if (isAndroidV2.value) {
      for (var i in specialChannel) {
        shell = Shell(workingDirectory: appDir);
        //打包
        showingLog.value += "打包渠道$i APK v2...\n";
        await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=$i --flavor=v2 --release
echo "\033[0;32m✔\033[0m APK v2 shema build Success"
    ''');
        showingLog.value += "APKv2打包成功\n";

        //搬移檔案
        showingLog.value += "搬移檔案\n";
        await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
        shell = shell.pushd("publish/outputs/$folder/0");
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v2-release.apk ./$i-v2.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
      }
    }

    if (isAndroidV1.value) {
      for (var i in specialChannel) {
        shell = Shell(workingDirectory: appDir);
        //打包
        showingLog.value += "打包渠道$i APK v1...\n";
        await shell.run('''
flutter build apk --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=$i --flavor=v1 --release
echo "\033[0;32m✔\033[0m APK v1 shema build Success"
    ''');
        showingLog.value += "APKv1打包成功\n";

        //搬移檔案
        showingLog.value += "搬移檔案\n";
        await shell.run('''
mkdir -p $appDir/publish
mkdir -p $appDir/publish/outputs
mkdir -p $appDir/publish/outputs/$folder
mkdir -p $appDir/publish/outputs/$folder/0
    ''');
        shell = shell.pushd("publish/outputs/$folder/0");
        await shell.run('''
mv $appDir/build/app/outputs/flutter-apk/app-v1-release.apk ./$i.apk
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/0\n";
      }
    }

    if (isIOS.value) {
      for (var i in specialChannel) {
        shell = Shell(workingDirectory: appDir);
        //打包
        showingLog.value += "打包渠道$i IOS...\n";
        await shell.run('''
flutter build ios --no-codesign --dart-define=ENVIRONMENT=$ENV --dart-define=CHANNEL=$i --release
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
mv $appDir/build/ios/iphoneos/Payload.ipa ./Payload.ipa
echo "\033[0;32m✔\033[0m 檔案搬移"
    ''');
        showingLog.value += "渠道$i搬移檔案完成 $appDir/publish/outputs/$folder/$i\n";
      }
    }

    showingLog.value += "打包完成\n";
  }
}

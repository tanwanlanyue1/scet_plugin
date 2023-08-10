import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scet_plugin/components/toast_widget/toast_widget.dart';

/// 监听首页返回 退出
class LogOut {
  static String title = '';
  static int popTrue = 0; //记录返回次数 为3就是退出app

  static init (String titles){
    print('———中联兴首页返回组件初始化--');
    title = titles;
  }
  ///判断是否退出
  static Future<bool> onWillPop() async{
    //web 打包后 appName 使用的 yaml 文件中的 name字段  也可以每次打包后修改 version.json中的 app_name
    //yaml 文件中的 name字段 只能是英文加下划线 所以中文下自定义一个字符
    // String title = '隐患排查与整改';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = kIsWeb ? title : packageInfo.appName;

    // print(popTrue);
    popTrue = popTrue + 1;
    ToastWidget.showToastMsg('连按两次退出${appName}');

    if (popTrue == 3) {
      pop();
    }

    return Future.delayed(const Duration(seconds: 2), () {
      popTrue = 1;
      return false;
    });
  }

  ///退出事件
  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

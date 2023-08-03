import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:scet_plugin/components/toast_widget/toast_widget.dart';
import 'package:scet_plugin/scet_plugin.dart';
import 'package:scet_plugin/tool/wx/WxConfigData.dart';

class WeiXinMiniProgram{

  static bool hasWeixinMiniProgram = false; // 微信小程序连接是否建立成功

  // 小程序的签名参数
  static Future init (WxConfigData wxConfigData) async {
    if(!kIsWeb) return;
    print('--中联兴js微信小程序通信插件初始化--');

    /// 注入js初始化 等待授权是否成功的方法
    ScetPlugin.weiXinConfigCallbackList(
        weiXinCallbackJsSdkInit: (bool e){
          // print('e,${e.toString()}');
          hasWeixinMiniProgram = e;
          // ToastWidget.showToastMsg('微信小程序授权${e ? '成功': '失败'}');
        }
    );

    await ScetPlugin.weiXinInit(wxConfigData);
  }

  /// 跳转到小程序某一个页面
  static toMiniProgramPage(String programPage){
    ScetPlugin.toWeiXinMiniProgramPage(programPage);
  }

  /// 给小程序发送消息（仅在页面退出等特定情况才能触发）
  static toMiniProgrampostMessage(Map data){

  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:scet_plugin/tool/wx/WxConfigData.dart';

import 'scet_plugin_platform_interface.dart';

/// An implementation of [ScetPluginPlatform] that uses method channels.
class MethodChannelScetPlugin extends ScetPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('scet_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 微信jssdk初始化
  @override
  Future<void> weiXinInit(WxConfigData wxConfigData) async {
    // return '未实现';
  }

  /// 微信jssdk方法回调列表
  @override
  void weiXinConfigCallbackList({
    Function? weiXinCallbackJsSdkInit
  }) async {
    // return '未实现';
  }

  /// 判断是否小程序
  @override
  bool getIsMiniProgramn()  {
    return false;
  }

  /// 判断是否是微信 的 浏览器
  @override
  bool getIsUsingWeChat() {
    return false;
  }

  @override
  Future<String?> toWeiXinMiniProgramPage(String page) async{
    return '未实现';
  }

  @override
  Future<String?> setTitle(String title) async{
    return '未实现';
  }
}

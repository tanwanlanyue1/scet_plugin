import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
  Future<String?> weiXinDownLoad(String filePath) async{
    return '未实现';
  }

  @override
  Future<String?> setTitle(String title) async{
    return '未实现';
  }
}

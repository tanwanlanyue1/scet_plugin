import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'scet_plugin_method_channel.dart';

abstract class ScetPluginPlatform extends PlatformInterface {
  /// Constructs a ScetPluginPlatform.
  ScetPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScetPluginPlatform _instance = MethodChannelScetPlugin();

  /// The default instance of [ScetPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelScetPlugin].
  static ScetPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScetPluginPlatform] when
  /// they register themselves.
  static set instance(ScetPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// web下的微信下载事件
  Future<String?> weiXinDownLoad(String filePath) {
    throw UnimplementedError('weiXinDownLoad() has not been implemented.');
  }

  /// 判断是否小程序
  bool getIsMiniProgramn() {
    throw UnimplementedError('getIsMiniProgramn() has not been implemented.');
  }

  /// 判断是否是微信 的 浏览器
  bool getIsUsingWeChat() {
    throw UnimplementedError('getIsUsingWeChat() has not been implemented.');
  }

  void setTitle(String title){
    throw UnimplementedError('setTitle() has not been implemented.');
  }
}

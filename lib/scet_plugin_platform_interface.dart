import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:scet_plugin/tool/wx/WxConfigData.dart';

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

  /// web下的微信jsSdk初始化配置
  Future<void> weiXinInit(WxConfigData wxConfigData) {
    throw UnimplementedError('wxInit() has not been implemented.');
  }

  // 微信jssdk的方法回调
  void weiXinConfigCallbackList({
    Function? weiXinCallbackJsSdkInit
  }){
    throw UnimplementedError('weiXinConfigCallbackList() has not been implemented.');
  }
  /// web下 微信页面跳转
  Future<String?> toWeiXinMiniProgramPage(String page) {
    throw UnimplementedError('toWeiXinMiniProgramPage() has not been implemented.');
  }

  /// 判断是否小程序
  bool getIsMiniProgramn() {
    throw UnimplementedError('getIsMiniProgramn() has not been implemented.');
  }

  /// 判断是否是微信 的 浏览器
  bool getIsUsingWeChat() {
    throw UnimplementedError('getIsUsingWeChat() has not been implemented.');
  }

  /// 页面标题修改
  void setTitle(String title){
    throw UnimplementedError('setTitle() has not been implemented.');
  }
}

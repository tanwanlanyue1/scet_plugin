import 'package:flutter_test/flutter_test.dart';
import 'package:scet_plugin/scet_plugin.dart';
import 'package:scet_plugin/scet_plugin_platform_interface.dart';
import 'package:scet_plugin/scet_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:scet_plugin/tool/wx/WxConfigData.dart';

class MockScetPluginPlatform
    with MockPlatformInterfaceMixin
    implements ScetPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');


  @override
  Future<String?> weiXinDownLoad(String filePath) {
    // TODO: implement weiXinDownLoad
    throw UnimplementedError();
  }

  @override
  bool getIsMiniProgramn() {
    // TODO: implement getIsMiniProgramn
    throw UnimplementedError();
  }

  @override
  bool getIsUsingWeChat() {
    // TODO: implement getIsUsingWeChat
    throw UnimplementedError();
  }

  @override
  void setTitle(String title) {
    // TODO: implement setTitle
  }

  @override
  Future<void> weiXinInit(WxConfigData wxConfigData) {
    // TODO: implement weiXinInit
    throw UnimplementedError();
  }
  
}

void main() {
  final ScetPluginPlatform initialPlatform = ScetPluginPlatform.instance;

  test('$MethodChannelScetPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScetPlugin>());
  });

  test('getPlatformVersion', () async {
    ScetPlugin scetPlugin = ScetPlugin();
    MockScetPluginPlatform fakePlatform = MockScetPluginPlatform();
    ScetPluginPlatform.instance = fakePlatform;

    expect(await scetPlugin.getPlatformVersion(), '42');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:scet_plugin/scet_plugin.dart';
import 'package:scet_plugin/scet_plugin_platform_interface.dart';
import 'package:scet_plugin/scet_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScetPluginPlatform
    with MockPlatformInterfaceMixin
    implements ScetPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
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

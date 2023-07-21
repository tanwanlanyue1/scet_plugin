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
}

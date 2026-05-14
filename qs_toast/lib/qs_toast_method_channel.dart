import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qs_toast_platform_interface.dart';

/// An implementation of [QsToastPlatform] that uses method channels.
class MethodChannelQsToast extends QsToastPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qs_toast');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

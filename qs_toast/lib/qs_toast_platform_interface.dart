import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qs_toast_method_channel.dart';

abstract class QsToastPlatform extends PlatformInterface {
  /// Constructs a QsToastPlatform.
  QsToastPlatform() : super(token: _token);

  static final Object _token = Object();

  static QsToastPlatform _instance = MethodChannelQsToast();

  /// The default instance of [QsToastPlatform] to use.
  ///
  /// Defaults to [MethodChannelQsToast].
  static QsToastPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QsToastPlatform] when
  /// they register themselves.
  static set instance(QsToastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

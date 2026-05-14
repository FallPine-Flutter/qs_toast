import 'package:flutter_test/flutter_test.dart';
import 'package:qs_toast/qs_toast.dart';
import 'package:qs_toast/qs_toast_platform_interface.dart';
import 'package:qs_toast/qs_toast_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQsToastPlatform
    with MockPlatformInterfaceMixin
    implements QsToastPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QsToastPlatform initialPlatform = QsToastPlatform.instance;

  test('$MethodChannelQsToast is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQsToast>());
  });

  test('getPlatformVersion', () async {
    QsToast qsToastPlugin = QsToast();
    MockQsToastPlatform fakePlatform = MockQsToastPlatform();
    QsToastPlatform.instance = fakePlatform;

    expect(await qsToastPlugin.getPlatformVersion(), '42');
  });
}

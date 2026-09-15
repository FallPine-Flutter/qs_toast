import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QsToast {
  /// 初始化
  /// 必须在MaterialApp的builder中调用
  static TransitionBuilder init({TransitionBuilder? builder}) {
    return EasyLoading.init(builder: builder);
  }

  /// 显示加载中弹窗
  static Future<void> loading({
    String? text,
    int? longestTime,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    VoidCallback? dismissAction,
  }) async {
    if (_isLoading && _loadingText == text) {
      return;
    }
    if (_isLoading && _loadingText != text) {
      await EasyLoading.dismiss(animation: true);
      Future.delayed(const Duration(milliseconds: 100), dismissAction);
    }
    await EasyLoading.show(status: text, maskType: maskType);
    if (longestTime != null) {
      _isLoading = true;
      _loadingText = text ?? "";
      Future.delayed(Duration(seconds: longestTime), () {
        if (_isLoading && _loadingText == text) {
          _isLoading = false;
          _loadingText = "";
          EasyLoading.dismiss(animation: true);
          Future.delayed(const Duration(milliseconds: 100), dismissAction);
        }
      });
    }
  }

  /// 显示文本弹窗
  static Future<void> text({
    required String text,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    Duration duration = const Duration(seconds: 1),
    VoidCallback? dismissAction,
  }) async {
    EasyLoading.showToast(text, maskType: maskType, duration: duration);
    Future.delayed(duration, dismissAction);
  }

  /// 显示成功弹窗
  static Future<void> success({
    required String text,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    Duration duration = const Duration(seconds: 1),
    VoidCallback? dismissAction,
  }) async {
    EasyLoading.showSuccess(text, maskType: maskType, duration: duration);
    Future.delayed(duration, dismissAction);
  }

  /// 显示错误弹窗
  static Future<void> error({
    required String text,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    Duration duration = const Duration(seconds: 1),
    VoidCallback? dismissAction,
  }) async {
    EasyLoading.showError(text, maskType: maskType, duration: duration);
    Future.delayed(duration, dismissAction);
  }

  /// 关闭弹窗
  static Future<void> dismiss({
    bool animation = true,
    VoidCallback? dismissAction,
  }) async {
    _isLoading = false;
    _loadingText = "";
    EasyLoading.dismiss(animation: animation);
    Future.delayed(const Duration(milliseconds: 100), dismissAction);
  }

  /// Property
  static bool _isLoading = false;
  static String _loadingText = "";
}

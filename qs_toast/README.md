# qs_toast

`qs_toast` 是一个基于 `flutter_easyloading` 封装的 Flutter Toast 插件，提供加载中、文本、成功、错误提示以及手动关闭能力。

## 功能特性

- 显示加载中提示
- 显示普通文本 Toast
- 显示成功提示
- 显示错误提示
- 手动关闭当前提示
- 支持遮罩类型、显示时长和关闭回调
- 支持在已有 `MaterialApp.builder` 基础上初始化

## 安装

在项目的 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  qs_toast: ^1.0.1
```

如果使用本地路径依赖：

```yaml
dependencies:
  qs_toast:
    path: ../qs_toast
```

然后执行：

```bash
flutter pub get
```

## 初始化

使用前需要在 `MaterialApp` 的 `builder` 中调用 `QsToast.init()`：

```dart
import 'package:flutter/material.dart';
import 'package:qs_toast/qs_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: QsToast.init(),
      home: const HomePage(),
    );
  }
}
```

如果项目已经配置了自定义 `builder`，可以通过 `builder` 参数传入原有逻辑：

```dart
MaterialApp(
  builder: QsToast.init(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context),
        child: child ?? const SizedBox.shrink(),
      );
    },
  ),
  home: const HomePage(),
);
```

## 使用方法

### 加载中

```dart
await QsToast.loading(text: '加载中...');
```

设置最长显示时间，超时后自动关闭：

```dart
await QsToast.loading(
  text: '提交中...',
  longestTime: 10,
  dismissAction: () {
    // 加载提示自动关闭后的回调
  },
);
```

### 文本提示

```dart
await QsToast.text(text: '操作已完成');
```

自定义显示时长：

```dart
await QsToast.text(
  text: '保存成功',
  duration: const Duration(seconds: 2),
);
```

### 成功提示

```dart
await QsToast.success(text: '提交成功');
```

### 错误提示

```dart
await QsToast.error(text: '提交失败，请稍后再试');
```

### 关闭提示

```dart
await QsToast.dismiss();
```

关闭后执行回调：

```dart
await QsToast.dismiss(
  dismissAction: () {
    // 提示关闭后的回调
  },
);
```

## API

### QsToast.init

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `builder` | `TransitionBuilder?` | `null` | 已有的 `MaterialApp.builder` 逻辑 |

### QsToast.loading

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `text` | `String?` | `null` | 加载提示文案 |
| `longestTime` | `int?` | `null` | 最长显示时间，单位为秒。设置后到时自动关闭 |
| `maskType` | `EasyLoadingMaskType` | `EasyLoadingMaskType.black` | 遮罩类型 |
| `dismissAction` | `VoidCallback?` | `null` | 自动关闭后的回调 |

### QsToast.text

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `text` | `String` | 必填 | 文本提示文案 |
| `maskType` | `EasyLoadingMaskType` | `EasyLoadingMaskType.black` | 遮罩类型 |
| `duration` | `Duration` | `Duration(seconds: 1)` | 显示时长 |
| `dismissAction` | `VoidCallback?` | `null` | 关闭后的回调 |

### QsToast.success

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `text` | `String` | 必填 | 成功提示文案 |
| `maskType` | `EasyLoadingMaskType` | `EasyLoadingMaskType.black` | 遮罩类型 |
| `duration` | `Duration` | `Duration(seconds: 1)` | 显示时长 |
| `dismissAction` | `VoidCallback?` | `null` | 关闭后的回调 |

### QsToast.error

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `text` | `String` | 必填 | 错误提示文案 |
| `maskType` | `EasyLoadingMaskType` | `EasyLoadingMaskType.black` | 遮罩类型 |
| `duration` | `Duration` | `Duration(seconds: 1)` | 显示时长 |
| `dismissAction` | `VoidCallback?` | `null` | 关闭后的回调 |

### QsToast.dismiss

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `animation` | `bool` | `true` | 关闭时是否显示动画 |
| `dismissAction` | `VoidCallback?` | `null` | 关闭后的回调 |

`maskType` 来自 `flutter_easyloading`。如果需要使用其他遮罩类型，可以引入：

```dart
import 'package:flutter_easyloading/flutter_easyloading.dart';
```

示例：

```dart
await QsToast.success(
  text: '保存成功',
  maskType: EasyLoadingMaskType.clear,
);
```

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:qs_toast/qs_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: QsToast.init(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('qs_toast 示例')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                QsToast.loading(text: '加载中...', longestTime: 5);
              },
              child: const Text('显示加载'),
            ),
            ElevatedButton(
              onPressed: () {
                QsToast.text(text: '这是一条提示');
              },
              child: const Text('显示文本'),
            ),
            ElevatedButton(
              onPressed: () {
                QsToast.success(text: '操作成功');
              },
              child: const Text('显示成功'),
            ),
            ElevatedButton(
              onPressed: () {
                QsToast.error(text: '操作失败');
              },
              child: const Text('显示错误'),
            ),
            ElevatedButton(
              onPressed: () {
                QsToast.dismiss();
              },
              child: const Text('关闭提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 注意事项

- `QsToast.init()` 必须配置在应用入口的 `MaterialApp.builder` 中。
- `loading` 设置 `longestTime` 后会进入加载状态，到时会自动关闭；也可以通过 `QsToast.dismiss()` 主动关闭。
- `text`、`success`、`error` 的 `dismissAction` 会在 `duration` 结束后触发。

## 平台支持

当前插件工程包含 Android 和 iOS 平台配置。

## 许可

本项目使用 `LICENSE` 文件中声明的许可证。

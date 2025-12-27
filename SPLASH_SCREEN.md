# 启动画面配置说明

## 问题原因

Flutter 应用启动时会经历以下过程：

1. **原生启动画面**：系统加载原生代码时显示（默认白屏）
2. **Dart 虚拟机初始化**：约 0.5-1 秒
3. **Flutter 启动页**：自定义的 SplashPage 显示

白屏出现在第 1 步，因为原生层还没配置启动画面。

## 解决方案

已完成以下配置：

### Android 配置

1. **launch_background.xml** - 启动背景

   - 位置：`android/app/src/main/res/drawable/`
   - 内容：粉色渐变背景 + 中心 Logo

2. **launch_icon.xml** - 启动图标

   - 位置：`android/app/src/main/res/drawable/`
   - 内容：白色圆角背景 + 粉色心形图标

3. **launch_background.xml (v21)** - Android 5.0+版本
   - 位置：`android/app/src/main/res/drawable-v21/`
   - 内容：与上述相同

### iOS 配置

1. **LaunchScreen.storyboard**
   - 位置：`ios/Runner/Base.lproj/`
   - 背景色：粉色 (#E91E63)

## 效果

现在应用启动流程：

1. ✅ **原生启动画面**：粉色渐变背景 + Logo 图标
2. ✅ **Flutter 启动页**：平滑过渡到动画启动页
3. ✅ **主页面**：淡入效果进入主页

**总启动时间**：约 2-3 秒

- 原生层：0.5-1 秒
- Flutter 启动页：2 秒
- 页面过渡：0.5 秒

## 测试

重新编译并运行应用：

### Android

```bash
flutter clean
flutter run
```

### iOS

```bash
flutter clean
cd ios
pod install
cd ..
flutter run
```

## 效果预览

启动画面特点：

- 🎨 粉色渐变背景（与应用主题一致）
- ❤️ 白色圆角卡片 + 粉色心形图标
- 🔄 从原生启动画面平滑过渡到 Flutter 启动页
- ⚡ 无白屏闪烁

## 注意事项

1. **第一次运行**：需要完全重新编译（flutter clean）
2. **热重载无效**：原生层修改需要重新运行应用
3. **不同设备**：在不同分辨率设备上测试效果

## 进一步优化（可选）

如果想要更精细的控制，可以使用 `flutter_native_splash` 包：

```yaml
dependencies:
  flutter_native_splash: ^2.3.10

flutter_native_splash:
  color: "#E91E63"
  image: assets/splash_logo.png
  android: true
  ios: true
```

然后运行：

```bash
flutter pub get
flutter pub run flutter_native_splash:create
```

这样可以自动生成各种尺寸的启动画面资源。

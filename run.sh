#!/bin/bash

# LifeTime 应用启动脚本

echo "🚀 启动 LifeTime 纪念日应用..."

# 检查是否有可用设备
echo "📱 检查可用设备..."
flutter devices

echo ""
echo "请选择运行平台："
echo "1) Chrome (Web)"
echo "2) macOS"
echo "3) iOS 模拟器"
echo "4) Android 模拟器"
read -p "输入选项 (1-4): " choice

case $choice in
  1)
    echo "🌐 在 Chrome 浏览器中启动..."
    flutter run -d chrome
    ;;
  2)
    echo "🖥️ 在 macOS 中启动..."
    flutter run -d macos
    ;;
  3)
    echo "📱 在 iOS 模拟器中启动..."
    flutter run -d ios
    ;;
  4)
    echo "🤖 在 Android 模拟器中启动..."
    flutter run -d android
    ;;
  *)
    echo "❌ 无效选项"
    exit 1
    ;;
esac

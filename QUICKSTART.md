# 快速开始指南

## 🎉 恭喜！

你的 LifeTime 纪念日应用已经成功初始化！

## 📋 项目已完成

✅ Flutter 开发环境安装  
✅ 项目结构创建  
✅ 核心功能实现  
✅ UI界面设计  
✅ 数据库配置  
✅ 状态管理设置  

## 🚀 立即运行

### 方法一：使用启动脚本
```bash
./run.sh
```

### 方法二：直接运行
```bash
# 在 Chrome 浏览器中运行（推荐用于快速测试）
flutter run -d chrome

# 在 macOS 中运行
flutter run -d macos
```

## 📱 查看可用设备
```bash
flutter devices
```

## 🏗️ 项目结构

```
lib/
├── main.dart                     # 应用入口
├── models/                       # 数据模型
│   └── anniversary.dart
├── providers/                    # 状态管理
│   └── anniversary_provider.dart
├── services/                     # 服务层
│   └── database_service.dart
├── pages/                        # 页面
│   ├── home_page.dart
│   ├── add_anniversary_page.dart
│   └── anniversary_detail_page.dart
├── theme/                        # 主题
│   └── app_theme.dart
└── utils/                        # 工具
    └── date_formatter.dart
```

## ✨ 核心功能

1. **纪念日管理**
   - 添加新纪念日
   - 编辑已有纪念日
   - 删除纪念日
   - 查看详细信息

2. **智能计算**
   - 自动计算已过时间
   - 显示距今天数
   - 计算下一个纪念日

3. **分类管理**
   - 🎂 生日
   - ❤️ 恋爱
   - 💍 结婚
   - 💼 工作
   - ⭐ 纪念
   - 🎉 节日
   - 📌 其他

4. **精美界面**
   - Material Design 3
   - 深色模式支持
   - 流畅动画效果

## 🛠️ 常用命令

```bash
# 安装依赖
flutter pub get

# 代码分析
flutter analyze

# 运行测试
flutter test

# 热重载（应用运行时按 r）
r

# 热重启（应用运行时按 R）
R

# 查看日志
flutter logs
```

## 📖 下一步

1. **运行应用** - 使用上面的命令运行应用
2. **添加纪念日** - 点击浮动按钮添加第一个纪念日
3. **查看详情** - 点击纪念日卡片查看详细信息
4. **自定义开发** - 根据需求添加更多功能

## 🔧 开发建议

### 推荐的开发流程
1. 先在 Web 或 macOS 上快速测试
2. 使用热重载加速开发
3. 经常运行 `flutter analyze` 检查代码
4. 完成功能后在真机上测试

### VS Code 插件推荐
- Flutter
- Dart
- Flutter Widget Snippets
- Awesome Flutter Snippets

## 📚 学习资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 语言教程](https://dart.dev/guides)
- [Material Design 指南](https://m3.material.io/)
- [Flutter 中文网](https://flutter.cn/)

## 🐛 遇到问题？

### 常见问题

**问题：无法运行项目**
```bash
# 清理并重新获取依赖
flutter clean
flutter pub get
```

**问题：设备检测不到**
```bash
# 检查设备连接
flutter doctor
flutter devices
```

**问题：构建失败**
```bash
# 升级 Flutter
flutter upgrade
```

## 📞 获取帮助

- 查看 `DEVELOPMENT.md` 了解详细开发文档
- 查看 `README.md` 了解项目概述
- 访问 Flutter 官方文档
- 在 GitHub Issues 中提问

---

🎊 开始创建你的第一个纪念日吧！

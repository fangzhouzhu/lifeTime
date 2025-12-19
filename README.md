# LifeTime - 纪念日应用 ⏰

一个精美的 Flutter 纪念日应用，帮助你记录生活中的重要时刻。

## ✨ 功能特性

- 📅 **纪念日管理** - 添加、编辑、删除各种重要日期
- 🎂 **多种分类** - 生日、恋爱、结婚、工作、纪念、节日等
- 📊 **智能统计** - 自动计算已过时间、距今天数、下次纪念日
- 🌙 **农历支持** - 支持农历和公历日期
- 🔔 **提醒功能** - 设置纪念日提醒（待实现）
- 🎨 **精美界面** - Material Design 3 设计风格
- 🌓 **深色模式** - 自动跟随系统主题

## 📱 截图

_即将添加截图_

## 🚀 快速开始

### 前置要求

- Flutter SDK 3.38.5 或更高版本
- Dart 3.10.4 或更高版本

### 安装步骤

1. **克隆项目**
```bash
git clone <repository-url>
cd lifeTime
```

2. **安装依赖**
```bash
flutter pub get
```

3. **运行应用**
```bash
# 在 iOS 模拟器运行
flutter run

# 在 Android 模拟器运行
flutter run

# 在 Chrome 浏览器运行
flutter run -d chrome

# 在 macOS 运行
flutter run -d macos
```

## 📦 项目结构

```
lib/
├── main.dart                 # 应用入口
├── models/                   # 数据模型
│   └── anniversary.dart      # 纪念日模型
├── providers/                # 状态管理
│   └── anniversary_provider.dart
├── services/                 # 服务层
│   └── database_service.dart # 数据库服务
├── pages/                    # 页面
│   ├── home_page.dart        # 首页
│   ├── add_anniversary_page.dart    # 添加/编辑页面
│   └── anniversary_detail_page.dart # 详情页面
├── theme/                    # 主题配置
│   └── app_theme.dart
└── utils/                    # 工具类
    └── date_formatter.dart   # 日期格式化
```

## 🛠️ 技术栈

- **Flutter** - 跨平台UI框架
- **Provider** - 状态管理
- **SQLite** - 本地数据库
- **Intl** - 国际化和日期处理
- **Material Design 3** - UI设计规范

## 📝 待办事项

- [ ] 实现通知提醒功能
- [ ] 添加小部件支持
- [ ] 数据导入/导出
- [ ] 云端同步
- [ ] 主题自定义
- [ ] 更多统计图表
- [ ] 农历转换完善

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 👨‍💻 作者

Your Name

---

用 ❤️ 制作

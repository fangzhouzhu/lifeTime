# LifeTime 项目开发文档

## 项目概述

LifeTime 是一个使用 Flutter 开发的纪念日管理应用，可以帮助用户记录和跟踪生活中的重要日期和时刻。

## 技术架构

### 核心技术
- **Flutter 3.38.5** - 跨平台UI框架
- **Dart 3.10.4** - 编程语言
- **Material Design 3** - 设计规范

### 状态管理
- **Provider** - 用于应用状态管理
- `AnniversaryProvider` - 管理纪念日数据的增删改查

### 数据持久化
- **SQLite** (`sqflite`) - 本地数据库
- **SharedPreferences** - 用于设置保存
- **DatabaseService** - 数据库操作封装

### UI组件库
- **Material Design 3** - 基础UI组件
- **Google Fonts** - 字体支持
- **Flutter Slidable** - 滑动操作组件

## 项目结构详解

```
lib/
├── main.dart                           # 应用入口，配置Provider和主题
│
├── models/                             # 数据模型层
│   └── anniversary.dart                # 纪念日数据模型
│       ├── Anniversary 类
│       ├── 数据转换方法 (toMap/fromMap)
│       └── 业务计算方法（天数、年数等）
│
├── providers/                          # 状态管理层
│   └── anniversary_provider.dart       # 纪念日状态管理
│       ├── 数据加载
│       ├── CRUD操作
│       └── 数据过滤和搜索
│
├── services/                           # 服务层
│   └── database_service.dart           # 数据库服务
│       ├── 数据库初始化
│       ├── CRUD操作
│       └── 单例模式实现
│
├── pages/                              # 页面层
│   ├── home_page.dart                  # 首页（纪念日列表）
│   │   ├── 即将到来的纪念日高亮显示
│   │   ├── 所有纪念日列表
│   │   └── 下拉刷新
│   │
│   ├── add_anniversary_page.dart       # 添加/编辑纪念日页面
│   │   ├── 表单验证
│   │   ├── 日期选择器
│   │   ├── 分类选择
│   │   └── 删除功能
│   │
│   └── anniversary_detail_page.dart    # 纪念日详情页
│       ├── 详细信息展示
│       ├── 时间统计
│       └── 编辑入口
│
├── theme/                              # 主题配置层
│   └── app_theme.dart                  # 应用主题
│       ├── 亮色主题
│       ├── 暗色主题
│       ├── 分类颜色映射
│       └── 分类图标映射
│
└── utils/                              # 工具类层
    └── date_formatter.dart             # 日期格式化工具
        ├── 日期格式化
        ├── 相对时间描述
        └── 时间计算

android/                                # Android 平台代码
ios/                                    # iOS 平台代码
macos/                                  # macOS 平台代码
web/                                    # Web 平台代码
windows/                                # Windows 平台代码
linux/                                  # Linux 平台代码
```

## 核心功能实现

### 1. 纪念日管理
- ✅ 添加纪念日
- ✅ 编辑纪念日
- ✅ 删除纪念日
- ✅ 查看纪念日列表
- ✅ 查看纪念日详情

### 2. 分类系统
支持的分类：
- 🎂 生日
- ❤️ 恋爱
- 💍 结婚
- 💼 工作
- ⭐ 纪念
- 🎉 节日
- 📌 其他

### 3. 时间计算
- 计算已过时间（年/月/天）
- 计算距今天数
- 计算下一个纪念日
- 相对时间描述（今天、明天、还有X天等）

### 4. UI特性
- Material Design 3 设计
- 响应式布局
- 深色模式支持
- 流畅动画
- 下拉刷新

## 数据模型

### Anniversary 模型
```dart
{
  id: int?,                    // 主键
  title: String,               // 标题
  date: DateTime,              // 日期
  description: String?,        // 描述
  category: String,            // 分类
  iconName: String?,           // 图标名称
  color: int?,                 // 颜色值
  isLunar: bool,              // 是否农历
  reminder: bool              // 是否提醒
}
```

## 数据库设计

### anniversaries 表
```sql
CREATE TABLE anniversaries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  date TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  iconName TEXT,
  color INTEGER,
  isLunar INTEGER NOT NULL DEFAULT 0,
  reminder INTEGER NOT NULL DEFAULT 1
)
```

## 开发指南

### 运行项目
```bash
# Web
flutter run -d chrome

# macOS
flutter run -d macos

# iOS
flutter run -d ios

# Android
flutter run -d android
```

### 调试
```bash
# 代码分析
flutter analyze

# 运行测试
flutter test

# 查看依赖
flutter pub deps
```

### 构建发布版本
```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# macOS
flutter build macos --release

# Web
flutter build web --release
```

## 待实现功能

### 高优先级
- [ ] 通知提醒功能
- [ ] 数据备份和恢复
- [ ] 搜索功能
- [ ] 设置页面

### 中优先级
- [ ] 农历日期转换
- [ ] 小部件支持
- [ ] 主题自定义
- [ ] 统计图表

### 低优先级
- [ ] 云端同步
- [ ] 分享功能
- [ ] 导出为图片
- [ ] 多语言支持

## 性能优化建议

1. **数据加载**
   - 实现分页加载
   - 添加缓存机制
   - 优化数据库查询

2. **UI渲染**
   - 使用 const 构造函数
   - 优化 build 方法
   - 减少不必要的 rebuild

3. **内存管理**
   - 及时释放资源
   - 避免内存泄漏
   - 优化图片加载

## 最佳实践

### 代码规范
- 遵循 Dart 官方代码规范
- 使用有意义的变量名
- 添加必要的注释
- 保持函数简洁

### 状态管理
- 合理使用 Provider
- 避免过度通知
- 分离业务逻辑和UI

### 错误处理
- 使用 try-catch 捕获异常
- 提供友好的错误提示
- 记录错误日志

## 相关资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 语言指南](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
- [Provider 文档](https://pub.dev/packages/provider)
- [SQLite 文档](https://pub.dev/packages/sqflite)

## 贡献指南

1. Fork 本仓库
2. 创建特性分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 许可证

MIT License

---

最后更新：2025年12月18日

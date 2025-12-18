# LifeTime App - UI Design Documentation

## 主页布局 (Home Page Layout)

```
┌─────────────────────────────────┐
│         LifeTime (标题栏)        │
├─────────────────────────────────┤
│                                 │
│  ┌──────────┐   ┌──────────┐  │
│  │    🔔    │   │    📅    │  │
│  │ 备忘提醒  │   │ 重要日子  │  │
│  │  (蓝色)  │   │  (粉色)  │  │
│  └──────────┘   └──────────┘  │
│                                 │
│  ┌──────────┐   ┌──────────┐  │
│  │    📸    │   │    ⚙️    │  │
│  │ 人生碎片  │   │  待开发   │  │
│  │  (橙色)  │   │  (灰色)  │  │
│  └──────────┘   └──────────┘  │
│                                 │
└─────────────────────────────────┘
```

## 功能模块详细说明

### 1. 备忘提醒 (Memo Reminder)
- **图标**: 🔔 通知铃铛图标 (Icons.notifications_active)
- **颜色**: 蓝色 (Colors.blue)
- **功能**: 创建备忘录和提醒事项
- **状态**: 已创建基础页面

### 2. 重要日子 (Important Days)
- **图标**: 📅 日历笔记图标 (Icons.event_note)
- **颜色**: 粉色 (Colors.pink)
- **功能**: 记录生活中的重要日子和纪念日
- **状态**: 已创建基础页面

### 3. 人生碎片 (Life Fragments)
- **图标**: 📸 照片库图标 (Icons.photo_library)
- **颜色**: 橙色 (Colors.orange)
- **功能**: 记录生活中的点点滴滴和珍贵时刻
- **状态**: 已创建基础页面

### 4. 待开发 (To Be Developed)
- **图标**: ⚙️ 设置图标 (Icons.settings)
- **颜色**: 灰色 (Colors.grey)
- **功能**: 更多精彩功能即将上线
- **状态**: 已创建基础页面

## 技术实现

### 按钮样式
- **尺寸**: 150px 高度，自适应宽度
- **圆角**: 16px 圆角边框
- **边框**: 2px 实线边框，透明度 30%
- **背景**: 主题色背景，透明度 10%
- **交互**: InkWell 点击效果

### 布局
- **主体**: Column + Row 布局
- **间距**: 模块间距 20px
- **边距**: 内容边距 20px
- **居中**: 垂直居中对齐

### 导航
- **方式**: Navigator.push 页面跳转
- **过渡**: MaterialPageRoute 默认过渡效果
- **返回**: AppBar 自带返回按钮

## 文件结构

```
lib/
├── main.dart                     # 应用入口，配置主题
├── pages/
│   ├── home_page.dart           # 主页，包含四个模块按钮
│   ├── memo_reminder_page.dart  # 备忘提醒功能页面
│   ├── important_days_page.dart # 重要日子功能页面
│   ├── life_fragments_page.dart # 人生碎片功能页面
│   └── to_be_developed_page.dart # 待开发功能页面
```

## 使用的 Flutter 组件

- MaterialApp
- Scaffold
- AppBar
- Column & Row
- Container
- InkWell
- Icon & Text
- Navigator
- MaterialPageRoute

# 纪念日媒体功能更新

## 新增功能

现在可以为每个纪念日添加图片或视频，让纪念日更加生动和有意义。

## 功能特性

### 1. 添加媒体

- 在添加/编辑纪念日页面中可以选择本地图片或视频
- 支持从相册选择
- 可以选择图片或视频（二选一）

### 2. 媒体预览

- 图片：在添加页面会显示缩略图预览
- 视频：显示视频图标提示已选择

### 3. 媒体展示

- 详情页面会完整展示选择的图片或视频
- 图片：全屏显示，保持比例
- 视频：内置播放器，支持播放/暂停控制

### 4. 媒体管理

- 可以删除已选择的媒体
- 可以重新选择新的媒体文件

## 技术实现

### 数据库更新

- 添加了 `mediaPath` 字段存储媒体文件路径
- 添加了 `mediaType` 字段存储媒体类型（image/video）
- 数据库版本升级到 v2，自动迁移旧数据

### 使用的依赖包

- `image_picker`: ^1.1.2 - 用于选择图片和视频
- `video_player`: ^2.9.2 - 用于播放视频

### 权限配置

#### Android (AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
```

#### iOS (Info.plist)

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>需要访问相册来选择图片和视频</string>
<key>NSCameraUsageDescription</key>
<string>需要访问相机来拍照和录像</string>
<key>NSMicrophoneUsageDescription</key>
<string>需要访问麦克风来录制视频</string>
```

## 使用方法

1. **添加媒体**

   - 打开添加/编辑纪念日页面
   - 滚动到"添加图片或视频"部分
   - 点击"选择图片"或"选择视频"按钮
   - 从相册中选择想要的文件

2. **查看媒体**

   - 打开纪念日详情页面
   - 媒体会显示在详细信息之前
   - 视频可以点击播放按钮进行播放

3. **删除媒体**
   - 在添加/编辑页面
   - 点击媒体预览卡片上的删除按钮

## 注意事项

1. 每个纪念日只能关联一个媒体文件（图片或视频）
2. 媒体文件存储在本地设备上
3. 首次使用时需要授予相应的权限
4. 视频文件可能较大，注意设备存储空间

## 后续优化建议

1. 支持多张图片或多个视频
2. 添加图片编辑功能（裁剪、滤镜等）
3. 支持从相机直接拍照/录像
4. 添加图片/视频压缩功能以节省存储空间
5. 支持云端存储同步

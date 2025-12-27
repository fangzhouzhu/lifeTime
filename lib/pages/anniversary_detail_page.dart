import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/anniversary.dart';
import '../utils/date_formatter.dart';
import '../theme/app_theme.dart';
import 'add_anniversary_page.dart';

/// 纪念日详情页面
class AnniversaryDetailPage extends StatefulWidget {
  final Anniversary anniversary;

  const AnniversaryDetailPage({super.key, required this.anniversary});

  @override
  State<AnniversaryDetailPage> createState() => _AnniversaryDetailPageState();
}

class _AnniversaryDetailPageState extends State<AnniversaryDetailPage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _videoController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    if (widget.anniversary.mediaType == 'video' &&
        widget.anniversary.mediaPath != null) {
      _initVideoPlayer();
    }
  }

  Future<void> _initVideoPlayer() async {
    _videoController = VideoPlayerController.file(
      File(widget.anniversary.mediaPath!),
    );
    await _videoController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _showImageViewer(String imagePath) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Hero(
                  tag: 'media_${widget.anniversary.id}',
                  child: Image.file(File(imagePath)),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getCategoryColor(widget.anniversary.category);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, color),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainInfo(color),
                    const SizedBox(height: 32),
                    if (widget.anniversary.mediaPath != null)
                      _buildMediaSection(),
                    if (widget.anniversary.mediaPath != null)
                      const SizedBox(height: 24),
                    _buildDetailsSection(),
                    const SizedBox(height: 24),
                    if (widget.anniversary.description != null)
                      _buildDescriptionSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddAnniversaryPage(anniversary: widget.anniversary),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color color) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.anniversary.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              AppTheme.getCategoryIcon(widget.anniversary.category),
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo(Color color) {
    final now = DateTime.now();
    final date = widget.anniversary.date;
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    final isFuture = targetDate.isAfter(today);
    final isToday = targetDate.isAtSameMomentAs(today);
    final daysDiff = targetDate.difference(today).inDays.abs();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  isFuture ? '还有' : '已过',
                  DateFormatter.formatYearsPassed(widget.anniversary.date),
                  color,
                ),
                Container(width: 1, height: 50, color: Colors.grey[300]),
                _buildInfoItem(
                  '距今',
                  isToday
                      ? '就是今天'
                      : (isFuture ? '还有$daysDiff天' : '$daysDiff天前'),
                  color,
                ),
              ],
            ),
            const Divider(height: 32),
            _buildNextAnniversary(color),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildNextAnniversary(Color color) {
    final nextDate = widget.anniversary.nextAnniversary;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final nextDay = DateTime(nextDate.year, nextDate.month, nextDate.day);
    final daysUntil = nextDay.difference(today).inDays;

    return Column(
      children: [
        Text('下一个纪念日', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 8),
        Text(
          DateFormatter.formatChineseDate(nextDate),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          daysUntil == 0 ? '就是今天！' : '还有 $daysUntil 天',
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '详细信息',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              Icons.calendar_today,
              '日期',
              DateFormatter.formatChineseDate(widget.anniversary.date),
            ),
            const Divider(),
            _buildDetailRow(Icons.category, '分类', widget.anniversary.category),
            const Divider(),
            _buildDetailRow(
              Icons.calendar_month,
              '日历类型',
              widget.anniversary.isLunar ? '农历' : '公历',
            ),
            const Divider(),
            _buildDetailRow(
              Icons.notifications,
              '提醒',
              widget.anniversary.reminder ? '开启' : '关闭',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '描述',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              widget.anniversary.description!,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaSection() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.anniversary.mediaType == 'image')
            InkWell(
              onTap: () => _showImageViewer(widget.anniversary.mediaPath!),
              child: Hero(
                tag: 'media_${widget.anniversary.id}',
                child: Image.file(
                  File(widget.anniversary.mediaPath!),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else if (widget.anniversary.mediaType == 'video' &&
              _videoController != null)
            InkWell(
              onTap: () => _showVideoViewer(widget.anniversary.mediaPath!),
              child: Stack(
                children: [
                  Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                      VideoProgressIndicator(
                        _videoController!,
                        allowScrubbing: true,
                        padding: const EdgeInsets.all(8),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _videoController!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            onPressed: () {
                              setState(() {
                                _videoController!.value.isPlaying
                                    ? _videoController!.pause()
                                    : _videoController!.play();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.fullscreen, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Text(
                            '全屏播放',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showVideoViewer(String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenVideoPlayer(videoPath: videoPath),
      ),
    );
  }
}

/// 全屏视频播放器
class _FullScreenVideoPlayer extends StatefulWidget {
  final String videoPath;

  const _FullScreenVideoPlayer({required this.videoPath});

  @override
  State<_FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<_FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.file(File(widget.videoPath));
    await _controller.initialize();
    setState(() {
      _isInitialized = true;
    });
    _controller.play();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('视频播放', style: TextStyle(color: Colors.white)),
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : GestureDetector(
              onTap: () {
                setState(() {
                  _showControls = !_showControls;
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  if (_showControls)
                    Container(
                      color: Colors.black38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  _formatDuration(_controller.value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _controller.value.position.inSeconds
                                        .toDouble(),
                                    max: _controller.value.duration.inSeconds
                                        .toDouble(),
                                    onChanged: (value) {
                                      _controller.seekTo(
                                        Duration(seconds: value.toInt()),
                                      );
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    inactiveColor: Colors.white30,
                                  ),
                                ),
                                Text(
                                  _formatDuration(_controller.value.duration),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_filled,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                      } else {
                                        _controller.play();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

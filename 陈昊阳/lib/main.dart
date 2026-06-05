import 'package:flutter/material.dart';

void main() {
  runApp(const CreativeDashboardApp());
}

class CreativeDashboardApp extends StatelessWidget {
  const CreativeDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '陈昊阳 · Flutter 创新控制台',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00D9FF),
          secondary: const Color(0xFF00D9FF),
          surface: const Color(0xFF161B22),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class Task {
  final String title;
  final String subtitle;
  bool isCompleted;
  final String assignee;

  Task({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    required this.assignee,
  });
}

class _DashboardPageState extends State<DashboardPage> {
  int creativeScore = 0;

  final List<Task> tasks = [
    Task(
      title: '运行 Flutter 项目',
      subtitle: 'flutter pub get && flutter run -d edge',
      isCompleted: true,
      assignee: '陈昊阳',
    ),
    Task(
      title: '个性化首页改造',
      subtitle: '标题、主题、姓名、学号、按钮已改造',
      isCompleted: true,
      assignee: '陈昊阳',
    ),
    Task(
      title: '创意灵感计数器',
      subtitle: '实现动态计数与进度追踪功能',
      isCompleted: true,
      assignee: '陈昊阳',
    ),
    Task(
      title: '添加 TODO 看板',
      subtitle: '通过 ListView 展示任务列表',
      isCompleted: false,
      assignee: '陈昊阳',
    ),
    Task(
      title: 'GitHub 协作提交',
      subtitle: '建立分支、提交 commit、创建 PR',
      isCompleted: false,
      assignee: '小组',
    ),
    Task(
      title: '截图与验收归档',
      subtitle: '将运行截图和提交记录保存',
      isCompleted: false,
      assignee: '小组',
    ),
  ];

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  int get pendingCount => tasks.where((t) => !t.isCompleted).length;

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void resetTasks() {
    setState(() {
      for (var task in tasks) {
        task.isCompleted = false;
      }
      creativeScore = 0;
    });
  }

  void completeNext() {
    final nextPending = tasks.indexWhere((t) => !t.isCompleted);
    if (nextPending != -1) {
      setState(() {
        tasks[nextPending].isCompleted = true;
        creativeScore += 1;
      });
    }
  }

  void sparkCreative() {
    setState(() {
      creativeScore += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1117),
              Color(0xFF0F1419),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧主内容区
                Expanded(
                  flex: 5,
                  child: _buildLeftPanel(),
                ),
                const SizedBox(width: 20),
                // 右侧看板区
                Expanded(
                  flex: 4,
                  child: _buildRightPanel(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: completeNext,
        backgroundColor: const Color(0xFF00D9FF),
        icon: const Icon(Icons.check_circle_outline, color: Color(0xFF0D1117)),
        label: const Text(
          '完成下一个 TODO',
          style: TextStyle(
            color: Color(0xFF0D1117),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ========== 左侧主面板 ==========
  Widget _buildLeftPanel() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部标签
          _buildTags(),
          const SizedBox(height: 24),
          // 主标题
          const Text(
            'Hello Flutter，',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const Text(
            '这是我的创新实验 Flutter 控制台',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          // 副标题信息
          Row(
            children: [
              _infoText('姓名: 陈昊阳'),
              _divider(),
              _infoText('学号: 20231060245'),
              _divider(),
              _infoText('已完成: 第14周Flutter任务'),
            ],
          ),
          const SizedBox(height: 28),
          // 进行中卡片
          _buildProgressCard(),
          const SizedBox(height: 20),
          // 统计数据
          _buildStatsRow(),
          const SizedBox(height: 20),
          // 创意灵感卡片
          _buildCreativeCard(),
        ],
      ),
    );
  }

  Widget _buildTags() {
    final tags = [
      ('Flutter', const Color(0xFF02569B)),
      ('Material 3', const Color(0xFF7C4DFF)),
      ('Animated UI', const Color(0xFFFF6D00)),
      ('CustomPainter', const Color(0xFF00C853)),
      ('Navigator', const Color(0xFF2979FF)),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: tag.$2.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: tag.$2.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
          child: Text(
            tag.$1,
            style: TextStyle(
              fontSize: 12,
              color: tag.$2.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProgressCard() {
    final progress = completedCount / tasks.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF161B22),
            const Color(0xFF1C2128),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF30363D),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Color(0xFF00D9FF),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                '进行中: 已完成 $completedCount 项，剩余 $pendingCount 项待办',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF00D9FF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFF21262D),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF00D9FF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.check_circle,
            value: '$completedCount / ${tasks.length}',
            label: '已完成 TODO',
            color: const Color(0xFF00D9FF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.pending_actions,
            value: '$pendingCount',
            label: '项 剩余待办',
            color: const Color(0xFFFFB800),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.local_fire_department,
            value: '$creativeScore',
            label: '个 创意火花',
            color: const Color(0xFFFF4757),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF30363D),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreativeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1F2E),
            Color(0xFF161B22),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '💡 创意灵感迸发',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '点击按钮激发你的创意思维，每 5 个灵感完成一个目标！',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: sparkCreative,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D9FF),
                        foregroundColor: const Color(0xFF0D1117),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.auto_awesome, size: 18),
                      label: const Text(
                        '激发灵感',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: resetTasks,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                        side: BorderSide(color: Colors.grey[700]!),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('重置'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00D9FF), Color(0xFF00A8CC)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$creativeScore',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D1117),
                    ),
                  ),
                  const Text(
                    '火花',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF0D1117),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== 右侧面板 ==========
  Widget _buildRightPanel() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF30363D),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.task_alt,
                      color: Color(0xFF00D9FF),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '课堂验收 TODO 看板',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    // 重置按钮
                    GestureDetector(
                      onTap: resetTasks,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            '重置待办状态',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '默认计数器已升级为待办事项可视化管理：可勾选、可统计、可重置',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 16),
                // 统计标签
                Row(
                  children: [
                    _statusBadge(
                      icon: Icons.check_circle,
                      label: '已完成',
                      count: completedCount,
                      color: const Color(0xFF00D9FF),
                    ),
                    const SizedBox(width: 8),
                    _statusBadge(
                      icon: Icons.pending,
                      label: '待完成',
                      count: pendingCount,
                      color: const Color(0xFFFFB800),
                    ),
                    const SizedBox(width: 8),
                    _statusBadge(
                      icon: Icons.format_list_numbered,
                      label: '总计',
                      count: tasks.length,
                      color: Colors.grey[400]!,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFF30363D)),
          // 任务列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return _buildTaskItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            '$label $count',
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(int index) {
    final task = tasks[index];

    return GestureDetector(
      onTap: () => toggleTask(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: task.isCompleted
              ? const Color(0xFF00D9FF).withValues(alpha: 0.05)
              : const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: task.isCompleted
                ? const Color(0xFF00D9FF).withValues(alpha: 0.3)
                : const Color(0xFF30363D),
            width: 0.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 复选框
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 12, top: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: task.isCompleted
                      ? const Color(0xFF00D9FF)
                      : Colors.grey[600]!,
                  width: 2,
                ),
                color: task.isCompleted ? const Color(0xFF00D9FF) : null,
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Color(0xFF0D1117))
                  : null,
            ),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: task.isCompleted
                                ? const Color(0xFF00D9FF)
                                : Colors.white,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: Colors.grey[600],
                          ),
                        ),
                      ),
                      if (task.isCompleted)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF00D9FF),
                          size: 16,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.person_outline,
                          size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '负责人: ${task.assignee}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
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

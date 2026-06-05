import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const InnovationHelloApp());
}

class InnovationHelloApp extends StatelessWidget {
  const InnovationHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF12B8A6);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '邱靖翔的创新实验 Flutter 控制台',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF07111F),
        fontFamilyFallback: const ['Microsoft YaHei', 'PingFang SC', 'Noto Sans CJK SC'],
      ),
      home: const InnovationDashboardPage(),
    );
  }
}

class InnovationDashboardPage extends StatefulWidget {
  const InnovationDashboardPage({super.key});

  @override
  State<InnovationDashboardPage> createState() => _InnovationDashboardPageState();
}

class _InnovationDashboardPageState extends State<InnovationDashboardPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motionController;

  bool githubSynced = false;
  int issueSeed = 4;

  late List<_TodoItem> todoItems;
  late List<_IssueTicket> issueTickets;

  final List<_GroupMember> teamMembers = const [
    _GroupMember(
      name: '邱靖翔',
      role: 'Flutter 页面与交互实现',
      email: 'qjx@example.com',
      contribution: '完成技术展示页、待办系统、截图与 GitHub 材料',
      isOwner: true,
    ),
    _GroupMember(
      name: '组员 A',
      role: '运行截图与设备验证',
      email: 'member-a@example.com',
      contribution: '负责 Chrome / Android 运行截图与红屏检查',
    ),
    _GroupMember(
      name: '组员 B',
      role: 'README 与 PR Review',
      email: 'member-b@example.com',
      contribution: '负责 README、PR 描述和 commits 页面截图',
    ),
  ];

  @override
  void initState() {
    super.initState();
    todoItems = _buildInitialTodos();
    issueTickets = _buildInitialIssues();
    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _motionController.dispose();
    super.dispose();
  }

  List<_TodoItem> _buildInitialTodos() {
    return const [
      _TodoItem(
        id: 'run',
        title: '运行 Flutter 项目',
        detail: '执行 flutter pub get 与 flutter run -d chrome',
        owner: '邱靖翔',
        icon: Icons.terminal_rounded,
        done: false,
      ),
      _TodoItem(
        id: 'personalize',
        title: '个性化首页改造',
        detail: '标题、主题、姓名、小组、按钮文案均已改造',
        owner: '邱靖翔',
        icon: Icons.dashboard_customize_rounded,
        done: false,
      ),
      _TodoItem(
        id: 'todo',
        title: '待办事项数量管理',
        detail: '将默认计数器升级为可勾选的课堂验收 TODO',
        owner: '邱靖翔',
        icon: Icons.checklist_rounded,
        done: false,
      ),
      _TodoItem(
        id: 'second-page',
        title: '新增协作详情页',
        detail: '通过 Navigator 跳转展示成员、Issues 和扩展功能',
        owner: '邱靖翔',
        icon: Icons.open_in_new_rounded,
        done: false,
      ),
      _TodoItem(
        id: 'github',
        title: 'GitHub 协作提交',
        detail: '建立分支、提交 commit、创建 PR 并保留截图',
        owner: '全组',
        icon: Icons.hub_rounded,
        done: false,
      ),
      _TodoItem(
        id: 'screenshot',
        title: '截图与验收归档',
        detail: '将运行截图和 commits / PR 截图放入 screenshots',
        owner: '全组',
        icon: Icons.verified_rounded,
        done: false,
      ),
    ];
  }

  List<_IssueTicket> _buildInitialIssues() {
    return const [
      _IssueTicket(
        id: '#1',
        title: '完成 Flutter 首页个性化改造',
        label: 'feature',
        status: 'Done',
        owner: '邱靖翔',
      ),
      _IssueTicket(
        id: '#2',
        title: '补充运行截图与验收说明',
        label: 'docs',
        status: 'Open',
        owner: '组员 A',
      ),
      _IssueTicket(
        id: '#3',
        title: 'Review PR 并检查 contributors 页面',
        label: 'review',
        status: 'Open',
        owner: '组员 B',
      ),
    ];
  }

  int get completedTasks => todoItems.where((item) => item.done).length;

  int get pendingTasks => todoItems.length - completedTasks;

  double get progressValue => todoItems.isEmpty ? 0 : completedTasks / todoItems.length;

  String get statusText {
    if (completedTasks == 0) {
      return '等待启动：点击按钮后，将依次完成课堂验收 TODO';
    }
    if (pendingTasks > 0) {
      return '进行中：已完成 $completedTasks 项，剩余 $pendingTasks 项待办';
    }
    return '已完成：首页、第二页、头像、TODO、Issues 扩展均可展示';
  }

  void completeNextTodo() {
    setState(() {
      final nextIndex = todoItems.indexWhere((item) => !item.done);
      if (nextIndex == -1) {
        todoItems = todoItems.map((item) => item.copyWith(done: false)).toList();
        githubSynced = false;
      } else {
        todoItems[nextIndex] = todoItems[nextIndex].copyWith(done: true);
        if (todoItems[nextIndex].id == 'github') {
          githubSynced = true;
        }
      }
    });
  }

  void toggleTodo(String id, bool done) {
    setState(() {
      todoItems = todoItems.map((item) {
        if (item.id != id) return item;
        return item.copyWith(done: done);
      }).toList();
      githubSynced = todoItems.any((item) => item.id == 'github' && item.done);
    });
  }

  void resetTodos() {
    setState(() {
      todoItems = todoItems.map((item) => item.copyWith(done: false)).toList();
      githubSynced = false;
    });
  }

  void toggleGithubSync() {
    setState(() {
      githubSynced = !githubSynced;
      todoItems = todoItems.map((item) {
        if (item.id == 'github') {
          return item.copyWith(done: githubSynced);
        }
        return item;
      }).toList();
    });
  }

  void createDemoIssue() {
    setState(() {
      issueTickets = [
        ...issueTickets,
        _IssueTicket(
          id: '#$issueSeed',
          title: '补充一次课堂演示记录 ${issueSeed - 3}',
          label: issueSeed.isEven ? 'docs' : 'enhancement',
          status: 'Open',
          owner: issueSeed.isEven ? '邱靖翔' : '全组',
        ),
      ];
      issueSeed += 1;
    });
  }

  void openExtensionPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExtensionShowcasePage(
          todoItems: todoItems,
          teamMembers: teamMembers,
          issueTickets: issueTickets,
          githubSynced: githubSynced,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('邱靖翔 · Flutter Innovation Console'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton.filledTonal(
            tooltip: '打开课后扩展详情页',
            onPressed: openExtensionPage,
            icon: const Icon(Icons.auto_awesome_motion_rounded),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 12),
            child: IconButton.filledTonal(
              tooltip: githubSynced ? 'GitHub 状态：已同步' : 'GitHub 状态：待同步',
              onPressed: toggleGithubSync,
              icon: Icon(githubSynced ? Icons.cloud_done_rounded : Icons.cloud_upload_rounded),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _motionController,
        builder: (context, _) {
          return CustomPaint(
            painter: _TechGridPainter(progress: _motionController.value),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: double.infinity),
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.25,
                  colors: [
                    Color(0xFF12395A),
                    Color(0xFF07111F),
                    Color(0xFF050913),
                  ],
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 920;
                    final content = isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: _HeroPanel(
                                  completedTasks: completedTasks,
                                  pendingTasks: pendingTasks,
                                  totalTasks: todoItems.length,
                                  statusText: statusText,
                                  progressValue: progressValue,
                                  githubSynced: githubSynced,
                                  onPrimaryPressed: completeNextTodo,
                                  onSecondaryPressed: toggleGithubSync,
                                  onDetailPressed: openExtensionPage,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    _TodoBoardPanel(
                                      todoItems: todoItems,
                                      completedTasks: completedTasks,
                                      pendingTasks: pendingTasks,
                                      onToggleTodo: toggleTodo,
                                      onReset: resetTodos,
                                    ),
                                    const SizedBox(height: 20),
                                    _IssuePreviewPanel(
                                      issueTickets: issueTickets,
                                      githubSynced: githubSynced,
                                      onCreateIssue: createDemoIssue,
                                      onDetailPressed: openExtensionPage,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _HeroPanel(
                                completedTasks: completedTasks,
                                pendingTasks: pendingTasks,
                                totalTasks: todoItems.length,
                                statusText: statusText,
                                progressValue: progressValue,
                                githubSynced: githubSynced,
                                onPrimaryPressed: completeNextTodo,
                                onSecondaryPressed: toggleGithubSync,
                                onDetailPressed: openExtensionPage,
                              ),
                              const SizedBox(height: 20),
                              _TodoBoardPanel(
                                todoItems: todoItems,
                                completedTasks: completedTasks,
                                pendingTasks: pendingTasks,
                                onToggleTodo: toggleTodo,
                                onReset: resetTodos,
                              ),
                              const SizedBox(height: 20),
                              _IssuePreviewPanel(
                                issueTickets: issueTickets,
                                githubSynced: githubSynced,
                                onCreateIssue: createDemoIssue,
                                onDetailPressed: openExtensionPage,
                              ),
                            ],
                          );

                    return Scrollbar(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 112),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1180),
                            child: content,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: completeNextTodo,
        tooltip: '完成一个待办事项',
        icon: Icon(pendingTasks == 0 ? Icons.replay_rounded : Icons.playlist_add_check_rounded),
        label: Text(pendingTasks == 0 ? '重置 TODO' : '完成下一个 TODO'),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.completedTasks,
    required this.pendingTasks,
    required this.totalTasks,
    required this.statusText,
    required this.progressValue,
    required this.githubSynced,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    required this.onDetailPressed,
  });

  final int completedTasks;
  final int pendingTasks;
  final int totalTasks;
  final String statusText;
  final double progressValue;
  final bool githubSynced;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final VoidCallback onDetailPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AvatarBadge(),
              const SizedBox(width: 16),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _TechChip(icon: Icons.flutter_dash_rounded, label: 'Flutter'),
                    _TechChip(icon: Icons.auto_awesome_rounded, label: 'Material 3'),
                    _TechChip(icon: Icons.animation_rounded, label: 'Animated UI'),
                    _TechChip(icon: Icons.draw_rounded, label: 'CustomPainter'),
                    _TechChip(icon: Icons.route_rounded, label: 'Navigator'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Hello Flutter，\n这是我的课后扩展技术展示页',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  color: colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            '姓名：邱靖翔｜小组：第 1 组｜已完成：第二页、成员列表、头像资源、TODO 数量管理、GitHub Issues 协作看板',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 26),
          AnimatedContainer(
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(0.28),
                  colorScheme.tertiary.withOpacity(0.14),
                ],
              ),
              border: Border.all(color: colorScheme.primary.withOpacity(0.38)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.insights_rounded, color: colorScheme.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        statusText,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: progressValue),
                  duration: const Duration(milliseconds: 560),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        minHeight: 11,
                        value: value,
                        backgroundColor: Colors.white.withOpacity(0.10),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 520;
                    final tiles = [
                      _MetricTile(
                        icon: Icons.task_alt_rounded,
                        label: '已完成 TODO',
                        value: '$completedTasks / $totalTasks',
                      ),
                      _MetricTile(
                        icon: Icons.pending_actions_rounded,
                        label: '剩余待办',
                        value: '$pendingTasks 项',
                      ),
                      _MetricTile(
                        icon: Icons.account_tree_rounded,
                        label: 'GitHub',
                        value: githubSynced ? '已同步' : '待提交',
                      ),
                    ];
                    if (compact) {
                      return Column(
                        children: [
                          for (int i = 0; i < tiles.length; i++) ...[
                            if (i > 0) const SizedBox(height: 12),
                            tiles[i],
                          ],
                        ],
                      );
                    }
                    return Row(
                      children: [
                        for (int i = 0; i < tiles.length; i++) ...[
                          if (i > 0) const SizedBox(width: 12),
                          Expanded(child: tiles[i]),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: onPrimaryPressed,
                icon: Icon(pendingTasks == 0 ? Icons.replay_rounded : Icons.check_circle_rounded),
                label: Text(pendingTasks == 0 ? '重置 TODO 演示' : '完成下一个 TODO'),
              ),
              OutlinedButton.icon(
                onPressed: onSecondaryPressed,
                icon: Icon(githubSynced ? Icons.cloud_done_rounded : Icons.cloud_upload_rounded),
                label: Text(githubSynced ? 'GitHub 已同步' : '标记 GitHub 同步'),
              ),
              OutlinedButton.icon(
                onPressed: onDetailPressed,
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('查看扩展详情页'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 78,
      height: 78,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.tertiary],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.32),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/avatars/qjx_avatar.png'),
        backgroundColor: Color(0xFF0B1524),
      ),
    );
  }
}

class _TodoBoardPanel extends StatelessWidget {
  const _TodoBoardPanel({
    required this.todoItems,
    required this.completedTasks,
    required this.pendingTasks,
    required this.onToggleTodo,
    required this.onReset,
  });

  final List<_TodoItem> todoItems;
  final int completedTasks;
  final int pendingTasks;
  final void Function(String id, bool done) onToggleTodo;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.checklist_rounded,
            title: '课堂验收 TODO 看板',
            subtitle: '默认计数器已升级为待办事项数量管理：可勾选、可统计、可重置',
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatusPill(icon: Icons.done_all_rounded, label: '已完成 $completedTasks'),
                _StatusPill(icon: Icons.pending_actions_rounded, label: '待完成 $pendingTasks'),
                _StatusPill(icon: Icons.playlist_add_check_rounded, label: '总计 ${todoItems.length}'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...todoItems.map((item) {
            return _TodoTile(
              item: item,
              onChanged: (done) => onToggleTodo(item.id, done),
            );
          }),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('重置待办状态'),
            ),
          ),
          Text(
            '截图建议：勾选 2–4 个 TODO 后再截图，能明显看到动态状态变化。',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

class _TodoTile extends StatelessWidget {
  const _TodoTile({required this.item, required this.onChanged});

  final _TodoItem item;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
      decoration: BoxDecoration(
        color: item.done ? colorScheme.primary.withOpacity(0.12) : Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: item.done ? colorScheme.primary.withOpacity(0.34) : Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: item.done,
            onChanged: (value) => onChanged(value ?? false),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          const SizedBox(width: 4),
          Icon(item.icon, color: item.done ? colorScheme.primary : colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        decoration: item.done ? TextDecoration.lineThrough : null,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.detail,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  '负责人：${item.owner}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IssuePreviewPanel extends StatelessWidget {
  const _IssuePreviewPanel({
    required this.issueTickets,
    required this.githubSynced,
    required this.onCreateIssue,
    required this.onDetailPressed,
  });

  final List<_IssueTicket> issueTickets;
  final bool githubSynced;
  final VoidCallback onCreateIssue;
  final VoidCallback onDetailPressed;

  @override
  Widget build(BuildContext context) {
    final visibleIssues = issueTickets.take(4).toList();

    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.bug_report_rounded,
            title: 'GitHub Issues 协作预案',
            subtitle: '把课堂任务拆成 Issue，用 label / assignee / status 表示小组分工',
          ),
          const SizedBox(height: 18),
          ...visibleIssues.map((issue) => _IssueTile(issue: issue)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.tonalIcon(
                onPressed: onCreateIssue,
                icon: const Icon(Icons.add_task_rounded),
                label: const Text('模拟新增 Issue'),
              ),
              OutlinedButton.icon(
                onPressed: onDetailPressed,
                icon: const Icon(Icons.groups_rounded),
                label: const Text('成员与扩展详情'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InlineNotice(
            icon: githubSynced ? Icons.verified_rounded : Icons.info_outline_rounded,
            text: githubSynced
                ? 'GitHub 状态已同步：提交时记得截图 commits / PR / Issues 页面。'
                : '建议实际仓库创建 3 个 Issue：运行截图、README 检查、PR Review。',
          ),
        ],
      ),
    );
  }
}

class ExtensionShowcasePage extends StatelessWidget {
  const ExtensionShowcasePage({
    super.key,
    required this.todoItems,
    required this.teamMembers,
    required this.issueTickets,
    required this.githubSynced,
  });

  final List<_TodoItem> todoItems;
  final List<_GroupMember> teamMembers;
  final List<_IssueTicket> issueTickets;
  final bool githubSynced;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final completed = todoItems.where((item) => item.done).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('课后扩展 · 协作详情页'),
        backgroundColor: const Color(0xFF07111F),
      ),
      body: CustomPaint(
        painter: const _StaticStarsPainter(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B1E33), Color(0xFF07111F), Color(0xFF050913)],
            ),
          ),
          child: SafeArea(
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 56),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _GlassPanel(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _AvatarBadge(),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '第 14 周课后可选扩展已全部实现',
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '本页使用 Navigator 从首页跳转进入，用于集中展示第二页面、成员列表、头像资源、TODO 数量管理和 GitHub Issues 协作方案。',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                            height: 1.55,
                                          ),
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        _StatusPill(icon: Icons.open_in_new_rounded, label: '第二页面'),
                                        _StatusPill(icon: Icons.groups_rounded, label: '成员列表'),
                                        _StatusPill(icon: Icons.image_rounded, label: '头像资源'),
                                        _StatusPill(icon: Icons.checklist_rounded, label: 'TODO：$completed / ${todoItems.length}'),
                                        _StatusPill(icon: Icons.bug_report_rounded, label: 'Issues：${issueTickets.length}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth >= 900;
                            final left = Column(
                              children: [
                                _ExtensionFeatureGrid(githubSynced: githubSynced),
                                const SizedBox(height: 20),
                                _MemberPanel(members: teamMembers),
                              ],
                            );
                            final right = Column(
                              children: [
                                _IssueBoardPanel(issues: issueTickets),
                                const SizedBox(height: 20),
                                _SubmissionPanel(todoItems: todoItems),
                              ],
                            );
                            if (!isWide) {
                              return Column(children: [left, const SizedBox(height: 20), right]);
                            }
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: left),
                                const SizedBox(width: 20),
                                Expanded(child: right),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExtensionFeatureGrid extends StatelessWidget {
  const _ExtensionFeatureGrid({required this.githubSynced});

  final bool githubSynced;

  @override
  Widget build(BuildContext context) {
    final items = [
      const _FeatureItem(
        icon: Icons.open_in_new_rounded,
        title: '新增第二页面',
        detail: '首页通过 Navigator.push 跳转到协作详情页，展示扩展成果。',
      ),
      const _FeatureItem(
        icon: Icons.groups_rounded,
        title: '小组成员列表',
        detail: '使用卡片列出组员、角色、贡献说明和联系人占位。',
      ),
      const _FeatureItem(
        icon: Icons.image_rounded,
        title: '头像与图片资源',
        detail: '新增 assets/avatars/qjx_avatar.png，并在 pubspec.yaml 中注册。',
      ),
      const _FeatureItem(
        icon: Icons.checklist_rounded,
        title: '待办事项数量',
        detail: '用 TODO 完成数 / 剩余数替代默认 Counter 点击次数。',
      ),
      _FeatureItem(
        icon: Icons.bug_report_rounded,
        title: 'GitHub Issues',
        detail: githubSynced ? '当前演示状态：GitHub 已同步。' : '当前演示状态：等待 GitHub 提交。',
      ),
    ];

    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.extension_rounded,
            title: '课后可选扩展完成情况',
            subtitle: '讲义中的 5 个扩展点已经全部落到页面和项目文件中',
          ),
          const SizedBox(height: 16),
          ...items.map((item) => _FeatureTile(item: item)),
        ],
      ),
    );
  }
}

class _MemberPanel extends StatelessWidget {
  const _MemberPanel({required this.members});

  final List<_GroupMember> members;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.groups_2_rounded,
            title: '小组成员与贡献记录',
            subtitle: '实际提交时把占位组员替换为真实姓名和 GitHub 账号即可',
          ),
          const SizedBox(height: 16),
          ...members.map((member) => _MemberCard(member: member)),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});

  final _GroupMember member;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(member.isOwner ? 0.075 : 0.045),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: member.isOwner ? colorScheme.primary.withOpacity(0.36) : Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primary.withOpacity(0.16),
            backgroundImage: member.isOwner ? const AssetImage('assets/avatars/qjx_avatar.png') : null,
            child: member.isOwner ? null : Text(member.name.substring(member.name.length - 1)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        member.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    if (member.isOwner) const _SmallTag(label: 'Owner'),
                  ],
                ),
                const SizedBox(height: 4),
                Text(member.role, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                Text(
                  member.contribution,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IssueBoardPanel extends StatelessWidget {
  const _IssueBoardPanel({required this.issues});

  final List<_IssueTicket> issues;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.bug_report_rounded,
            title: 'GitHub Issues 看板',
            subtitle: '用于说明小组如何把任务拆解、分配和追踪',
          ),
          const SizedBox(height: 16),
          ...issues.map((issue) => _IssueTile(issue: issue)),
          const SizedBox(height: 12),
          const _InlineNotice(
            icon: Icons.lightbulb_rounded,
            text: '真实仓库中可以创建同名 Issues，并在 PR 正文写 closes #1 / refs #2，展示协作规范。',
          ),
        ],
      ),
    );
  }
}

class _SubmissionPanel extends StatelessWidget {
  const _SubmissionPanel({required this.todoItems});

  final List<_TodoItem> todoItems;

  @override
  Widget build(BuildContext context) {
    final done = todoItems.where((item) => item.done).length;
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.assignment_turned_in_rounded,
            title: '课堂提交说明',
            subtitle: '截图时建议同时展示首页 TODO 状态和本页扩展清单',
          ),
          const SizedBox(height: 16),
          _InlineNotice(
            icon: Icons.screenshot_monitor_rounded,
            text: '个人截图：页面运行正常，能看到姓名、小组、头像、TODO 完成数和第二页面入口。',
          ),
          const SizedBox(height: 10),
          _InlineNotice(
            icon: Icons.commit_rounded,
            text: 'GitHub 截图：commits / PR / Issues 页面任选其一，但必须能看到账号和提交记录。',
          ),
          const SizedBox(height: 10),
          _InlineNotice(
            icon: Icons.analytics_rounded,
            text: '当前 TODO 进度：$done / ${todoItems.length}。运行时点击按钮可继续改变状态。',
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.item});

  final _FeatureItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  item.detail,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IssueTile extends StatelessWidget {
  const _IssueTile({required this.issue});

  final _IssueTicket issue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final done = issue.status.toLowerCase() == 'done';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: done ? colorScheme.primary.withOpacity(0.10) : Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: done ? colorScheme.primary.withOpacity(0.30) : Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: done ? colorScheme.primary : colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(issue.id, style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w900)),
                    _SmallTag(label: issue.label),
                    _SmallTag(label: issue.status),
                  ],
                ),
                const SizedBox(height: 6),
                Text(issue.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 5),
                Text(
                  'Assignee：${issue.owner}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelinePanel extends StatelessWidget {
  const _TimelinePanel({
    required this.taskItems,
    required this.completedTasks,
    required this.githubSynced,
  });

  final List<_TodoItem> taskItems;
  final int completedTasks;
  final bool githubSynced;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.route_rounded,
            title: '课堂验收路线图',
            subtitle: '点击按钮后逐步点亮，每一步都对应讲义检查项',
          ),
          const SizedBox(height: 22),
          ...List.generate(taskItems.length, (index) {
            final item = taskItems[index];
            final isDone = index < completedTasks;
            final isCurrent = index == completedTasks && completedTasks < taskItems.length;

            return _TimelineItem(
              item: item,
              isDone: isDone,
              isCurrent: isCurrent,
              isLast: index == taskItems.length - 1,
            );
          }),
          const SizedBox(height: 20),
          _InlineNotice(
            icon: githubSynced ? Icons.verified_rounded : Icons.info_outline_rounded,
            text: githubSynced
                ? 'GitHub 协作状态已标记：提交时记得截图 commits / PR 页面。'
                : '提交前建议执行：git status → git add → git commit → git push。',
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.item,
    required this.isDone,
    required this.isCurrent,
    required this.isLast,
  });

  final _TodoItem item;
  final bool isDone;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor = isDone ? colorScheme.primary : colorScheme.tertiary;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 38,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 320),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDone || isCurrent) ? activeColor.withOpacity(0.22) : Colors.white.withOpacity(0.06),
                    border: Border.all(
                      color: (isDone || isCurrent) ? activeColor : Colors.white.withOpacity(0.12),
                      width: 1.2,
                    ),
                  ),
                  child: Icon(
                    isDone ? Icons.done_rounded : item.icon,
                    size: 20,
                    color: (isDone || isCurrent) ? activeColor : colorScheme.onSurfaceVariant,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 34,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: isDone ? activeColor.withOpacity(0.55) : Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 260),
              opacity: isDone || isCurrent ? 1 : 0.62,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.detail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.45,
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
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _PanelTitle extends StatelessWidget {
  const _PanelTitle({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.primary.withOpacity(0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  const _SmallTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.tertiary.withOpacity(0.24)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _InlineNotice extends StatelessWidget {
  const _InlineNotice({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.45)),
          ),
        ],
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1727).withOpacity(0.82),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.11)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.32),
            blurRadius: 32,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _TodoItem {
  const _TodoItem({
    required this.id,
    required this.title,
    required this.detail,
    required this.owner,
    required this.icon,
    required this.done,
  });

  final String id;
  final String title;
  final String detail;
  final String owner;
  final IconData icon;
  final bool done;

  _TodoItem copyWith({bool? done}) {
    return _TodoItem(
      id: id,
      title: title,
      detail: detail,
      owner: owner,
      icon: icon,
      done: done ?? this.done,
    );
  }
}

class _IssueTicket {
  const _IssueTicket({
    required this.id,
    required this.title,
    required this.label,
    required this.status,
    required this.owner,
  });

  final String id;
  final String title;
  final String label;
  final String status;
  final String owner;
}

class _GroupMember {
  const _GroupMember({
    required this.name,
    required this.role,
    required this.email,
    required this.contribution,
    this.isOwner = false,
  });

  final String name;
  final String role;
  final String email;
  final String contribution;
  final bool isOwner;
}

class _FeatureItem {
  const _FeatureItem({required this.icon, required this.title, required this.detail});

  final IconData icon;
  final String title;
  final String detail;
}

class _TechGridPainter extends CustomPainter {
  const _TechGridPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.035)
      ..strokeWidth = 1;
    const step = 44.0;
    final dx = (progress * step) % step;

    for (double x = -step + dx; x < size.width + step; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height + step; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final center = Offset(size.width * 0.78, size.height * 0.22);
    for (int i = 0; i < 4; i++) {
      final radius = 42.0 + i * 32 + math.sin(progress * math.pi * 2 + i) * 4;
      glowPaint.color = const Color(0xFF12B8A6).withOpacity(0.18 - i * 0.03);
      canvas.drawCircle(center, radius, glowPaint);
    }

    final nodePaint = Paint()..color = const Color(0xFF6BE7D8).withOpacity(0.34);
    for (int i = 0; i < 10; i++) {
      final angle = progress * math.pi * 2 + i * 0.72;
      final point = Offset(
        center.dx + math.cos(angle) * (72 + i * 6),
        center.dy + math.sin(angle) * (42 + i * 4),
      );
      canvas.drawCircle(point, 2.2 + (i % 3), nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TechGridPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _StaticStarsPainter extends CustomPainter {
  const _StaticStarsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.055);
    for (int i = 0; i < 80; i++) {
      final x = (i * 73) % math.max(size.width, 1);
      final y = (i * 47) % math.max(size.height, 1);
      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1 + (i % 3) * 0.55, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StaticStarsPainter oldDelegate) => false;
}

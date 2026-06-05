import 'package:flutter/material.dart';

void main() {
  runApp(const InnovationHelloApp());
}

class InnovationHelloApp extends StatelessWidget {
  const InnovationHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '周文宾的创新实验 Flutter 首页',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HelloHomePage(),
    );
  }
}

class HelloHomePage extends StatefulWidget {
  const HelloHomePage({super.key});

  @override
  State<HelloHomePage> createState() => _HelloHomePageState();
}

class _HelloHomePageState extends State<HelloHomePage> {
  int completedTasks = 0;

  void finishOneTask() {
    setState(() {
      completedTasks += 1;
    });
    if (completedTasks > 0 && completedTasks % 5 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('太棒了！已完成 $completedTasks 次打卡 🎉'),
        backgroundColor: Colors.blue.shade700,
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('周文宾的创新实验 Flutter 首页'),
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: '创新实验 Flutter 入门',
                applicationVersion: '第14周',
                children: [
                  Text('\n姓名：周文宾\n学号：20231060154\n课程：软件工程创新实验'),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 火箭图标 + 圆形背景装饰
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.rocket_launch, size: 80, color: Colors.blue),
              ),
              const SizedBox(height: 28),

              // 大标题
              const Text(
                'Hello Flutter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.blue),
              ),
              const SizedBox(height: 8),

              // 副标题说明
              const Text(
                '我已经完成第 14 周入门任务！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  '📅 2026年6月5日',
                  style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                ),
              ),

              // 分隔线
              Padding(
                padding: EdgeInsets.only(top: 28, left: 40, right: 40),
                child: Divider(color: Colors.blue.shade200, thickness: 1.5),
              ),

              // 个人信息卡片
              Card(
                elevation: 2,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.blue.shade50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blue.shade300,
                        child: Text('周', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_outline, size: 16, color: Colors.blue.shade700),
                              SizedBox(width: 6),
                              Text('姓名：周文宾', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.badge_outlined, size: 16, color: Colors.blue.shade700),
                              SizedBox(width: 6),
                              Text('学号：20231060154', style: TextStyle(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 计数器区域 - 大号数字
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade400]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withValues(alpha: 0.25), blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '$completedTasks',
                      style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '今日已完成任务次数',
                      style: TextStyle(fontSize: 15, color: Colors.white70, letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: finishOneTask,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('完成一次打卡', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        tooltip: '点击完成一次打卡任务',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

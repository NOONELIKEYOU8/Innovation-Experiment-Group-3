# 邱靖翔的创新实验 Flutter 技术展示页（课后扩展完整版）

这是根据“创新实验第 14 周 Flutter Hello World 个性化修改与 GitHub 小组协作提交”任务制作的可运行 Flutter 项目。项目已经从默认 Hello World / Counter 页面升级为一个暗色科技风课堂任务控制台，并把讲义中的课后可选扩展也全部实现。

## 已完成的基础要求

讲义要求个人任务至少完成 4 处个性化修改，并保证按钮点击后页面有可见变化。本项目已完成并超过要求：

- AppBar 标题改为 `邱靖翔 · Flutter Innovation Console`；
- 页面包含姓名、小组和第 14 周任务说明；
- 页面主题从默认浅色计数器改为 Material 3 暗色科技风；
- 计数含义从默认点击次数改为课堂验收 TODO 完成数量；
- 点击按钮后，TODO 数量、剩余数量、进度条、状态文本都会变化；
- 保留 GitHub 提交、PR、截图、验收清单相关说明。

## 课后可选扩展完成情况

讲义提供的 5 个可选扩展已全部做进项目中：

1. **新增第二个页面**  
   首页点击 `查看扩展详情页`，通过 `Navigator.push` 进入“课后扩展 · 协作详情页”。

2. **添加列表展示小组成员**  
   第二页提供“小组成员与贡献记录”卡片，展示成员姓名、角色、贡献说明。实际提交前可把占位成员替换为真实组员。

3. **使用图片或头像**  
   新增 `assets/avatars/qjx_avatar.png`，并在 `pubspec.yaml` 中注册。首页和第二页都会加载该头像资源。

4. **把计数器改成待办事项数量**  
   默认 Counter 已替换为 TODO 看板，支持勾选、完成下一个 TODO、重置状态，并动态展示 `已完成 / 剩余 / 总计`。

5. **学习使用 GitHub Issues 分配任务**  
   首页和第二页都加入 GitHub Issues 协作看板，展示 Issue 编号、label、status、assignee。`docs/github_issues.md` 里写好了实际创建 Issues 的建议模板。

## 技术展示点

本项目尽量不引入复杂第三方依赖，只使用 Flutter 官方能力展示技术力：

- `MaterialApp` + `ThemeData`：Material 3 暗色主题；
- `AnimationController` + `AnimatedBuilder`：驱动动态科技背景；
- `CustomPainter`：绘制网格、光环、节点和星点背景；
- `LayoutBuilder`：宽屏双栏、窄屏单栏的响应式布局；
- `TweenAnimationBuilder`：TODO 进度条平滑过渡；
- `Navigator.push`：实现首页到第二页面的跳转；
- `Image.asset` / `CircleAvatar`：加载本地头像资源；
- `Checkbox` + 状态管理：替代默认计数器，形成可验收 TODO 系统；
- 组件化拆分：Hero、TodoBoard、IssueBoard、MemberPanel、FeatureGrid 等多个自定义 Widget。

## 运行方式

进入项目根目录后执行：

```bash
flutter pub get
flutter run
```

课堂上优先使用 Chrome 的话：

```bash
flutter run -d chrome
```

如果你的本机缺少 Android / Windows / Web 平台目录，可以在项目根目录执行一次：

```bash
flutter create .
flutter pub get
flutter run -d chrome
```

`flutter create .` 用于补齐本机平台目录，通常不会覆盖已经写好的 `lib/main.dart`。

## 运行后检查

建议至少检查以下内容：

1. 页面没有红屏和 overflow 黄黑条；
2. 首页能看到标题、姓名、小组、头像和 TODO 看板；
3. 点击右下角 `完成下一个 TODO` 后，已完成数量、剩余数量、进度条和状态文本发生变化；
4. 手动勾选 TODO 后，数量统计会变化；
5. 点击 `查看扩展详情页` 可以进入第二页；
6. 第二页能看到课后扩展清单、小组成员列表和 GitHub Issues 看板；
7. 点击 `模拟新增 Issue` 后，Issues 数量会增加；
8. 点击云朵按钮后，GitHub 同步状态会变化。

## 推荐截图方式

个人运行截图建议包含：

- 首页标题、头像、姓名、小组；
- 至少 2 个已勾选的 TODO；
- 进度条和剩余待办数量；
- 右侧 GitHub Issues 看板。

第二张截图可选：

- 第二页的“课后扩展完成情况”；
- 小组成员列表；
- GitHub Issues 看板。

截图文件建议命名为：

```text
邱靖翔_flutter_第14周_首页运行截图.png
邱靖翔_flutter_第14周_扩展页截图.png
邱靖翔_flutter_第14周_GitHub提交记录.png
```

## GitHub 小组提交建议

第一次提交：

```bash
git init
git add .
git commit -m "complete flutter hello optional extensions"
git branch -M main
git remote add origin 你的仓库地址
git push -u origin main
```

如果按个人分支提交：

```bash
git clone 小组仓库地址
cd 小组仓库目录
git checkout -b qjx-hello-extended
# 复制本项目文件到仓库目录后：
flutter pub get
flutter run -d chrome
git add lib/main.dart pubspec.yaml README.md docs screenshots assets .gitignore
git commit -m "complete advanced flutter hello page with optional extensions"
git push -u origin qjx-hello-extended
```

PR 标题建议：

```text
邱靖翔：完成第 14 周 Flutter 个性化页面与课后扩展
```

PR 正文建议：

```text
本次提交完成第 14 周 Flutter Hello World 个性化改造及课后可选扩展：

1. 将默认计数器页面升级为暗色科技风课堂任务控制台；
2. 新增第二页面，用于展示扩展功能和协作说明；
3. 新增小组成员列表与本地头像资源；
4. 将计数器升级为 TODO 待办数量管理；
5. 增加 GitHub Issues 协作看板，展示任务拆分、负责人和状态；
6. 补充 README、验收清单、GitHub workflow 和 Issues 模板说明。
```

## 群内提交文案

```text
姓名：邱靖翔
小组：第 1 组
我修改了：AppBar 标题、页面主题、个人/小组信息、按钮文案、计数含义、TODO 看板、进度条、动态背景、第二页面、小组成员列表、头像资源、GitHub Issues 看板。
技术点：Material 3、AnimationController、AnimatedBuilder、CustomPainter、LayoutBuilder、TweenAnimationBuilder、Navigator、Image.asset、Checkbox 状态管理、响应式布局。
运行检查：页面无红屏，点击按钮和勾选 TODO 后，完成数量、剩余数量、进度条、状态文本均会变化；第二页面可以正常跳转。
截图：见下图
GitHub 提交记录：见 commits / PR / Issues 截图
```

## 文件说明

```text
lib/main.dart                  Flutter 主页面、第二页面、TODO、Issues、成员列表等全部核心代码
pubspec.yaml                   Flutter 项目配置，已注册本地头像资源
assets/avatars/qjx_avatar.png  本地头像图片资源
web/                           Chrome/Web 运行所需基础目录
docs/checklist.md              个人与小组验收清单
docs/github_workflow.md        GitHub 分支提交流程
docs/github_issues.md          GitHub Issues 拆分和模板说明
screenshots/                   运行截图存放位置
.gitignore                     忽略 build/、.dart_tool/ 等本地构建缓存
```

## 注意

压缩包没有包含 `build/`、`.dart_tool/` 等构建缓存。运行截图需要在你本机运行后截取。

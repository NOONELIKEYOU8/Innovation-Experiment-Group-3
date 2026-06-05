# GitHub 小组协作提交流程

## 方式一：直接提交到小组仓库

```bash
git clone 小组仓库地址
cd 小组仓库目录
cp -r 本项目中的文件到小组仓库目录
flutter pub get
flutter run -d chrome
git status
git add .
git commit -m "complete flutter hello optional extensions"
git push
```

## 方式二：个人分支 + Pull Request

```bash
git clone 小组仓库地址
cd 小组仓库目录
git checkout -b qjx-hello-extended
cp -r 本项目中的文件到小组仓库目录
flutter pub get
flutter run -d chrome
git add lib/main.dart pubspec.yaml README.md docs screenshots assets .gitignore
git commit -m "complete advanced flutter hello page with optional extensions"
git push -u origin qjx-hello-extended
```

然后在 GitHub 页面点击 `Compare & pull request`。

## PR 标题建议

```text
邱靖翔：完成第 14 周 Flutter 个性化页面与课后扩展
```

## PR 正文建议

```text
本次提交完成 Flutter Hello World 个性化改造及课后可选扩展，主要包括：

1. 将默认计数器页面升级为暗色科技风控制台；
2. 新增第二个页面，用于展示扩展功能、小组成员和协作说明；
3. 增加姓名、小组、头像、本地资源和课堂验收 TODO；
4. 使用 Material 3、AnimationController、CustomPainter、LayoutBuilder、TweenAnimationBuilder、Navigator 和 Image.asset；
5. 将默认点击计数器改成待办事项数量管理；
6. 增加 GitHub Issues 看板，展示任务拆分、负责人、label 和状态；
7. 补充 README、验收清单、截图目录和 Issues 模板说明。

Closes #1
Refs #2
Refs #3
```

## 建议配合 Issues

可以在 GitHub 仓库创建 3 个 Issue：

1. `完成 Flutter 首页个性化改造`；
2. `补充运行截图与验收说明`；
3. `Review PR 并检查 contributors 页面`。

详细模板见：`docs/github_issues.md`。

## 最终检查

提交前建议执行：

```bash
git status
flutter pub get
flutter run -d chrome
```

确认没有红屏、没有 overflow、第二页面能正常打开后再截图提交。

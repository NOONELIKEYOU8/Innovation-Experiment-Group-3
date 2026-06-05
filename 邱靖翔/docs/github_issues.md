# GitHub Issues 协作任务拆分建议

本项目已在页面中模拟了 GitHub Issues 看板。实际提交到小组仓库时，可以在 GitHub 仓库的 Issues 页面创建以下任务，用来证明小组协作过程。

## 推荐 Issue 1

**Title**

```text
完成 Flutter 首页个性化改造
```

**Label**

```text
feature
```

**Assignee**

```text
邱靖翔
```

**Description**

```text
任务内容：
1. 修改 AppBar 标题、页面主题和个人信息；
2. 将默认 Counter 页面改为技术展示页；
3. 确保按钮点击后页面状态发生变化；
4. 本机运行无红屏和 overflow。
```

## 推荐 Issue 2

**Title**

```text
补充运行截图与验收说明
```

**Label**

```text
docs
```

**Description**

```text
任务内容：
1. 运行 flutter pub get；
2. 运行 flutter run -d chrome；
3. 截取首页运行图和扩展页截图；
4. 将截图放入 screenshots/ 或提交到群里。
```

## 推荐 Issue 3

**Title**

```text
Review PR 并检查 contributors 页面
```

**Label**

```text
review
```

**Description**

```text
任务内容：
1. 检查 PR 中是否包含 lib/main.dart、pubspec.yaml、README.md、docs/、assets/；
2. 检查 commit 信息是否清晰；
3. 检查 contributors / commits 页面是否能看到组员贡献；
4. Review 通过后合并。
```

## PR 正文关联 Issue 示例

```text
本 PR 完成第 14 周 Flutter 个性化改造与课后扩展。

Closes #1
Refs #2
Refs #3
```

## 截图建议

课堂提交时可以截图：

1. Issues 列表页面；
2. 某个 Issue 的 assignee / label / status；
3. PR 页面中关联 Issue 的正文；
4. commits 或 contributors 页面。

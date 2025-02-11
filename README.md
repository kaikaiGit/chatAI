# chatAI
## description：
  一个基于鸿蒙系统的 AI 对话助手，支持用户输入消息，并调用 AI 接口返回智能回复，旨在提供便捷的、仿真的对话体验。

## 功能介绍：
1. 模仿**微信聊天**页面实现的一个**AI对话**app
2. 生成式AI接口调用了**讯飞星火**提供的API，使用到了http模块进行网络请求
3. 将每次用户发送的问题以及AI进行的回答进行了本地的**持久化存储**，更加接近微信朋友聊天的场景
4. 其中对应用图标，应用名进行了配置，同时，还对部分文字内容进行了**中文**和**英文**两种语言的**国际化配置**

## 概要设计：
1. 应用名称：小智聊天助手 | chatAI
2. 开发语言：ArkTS
3. 开发工具：DevEco Studio
4. 运行环境：HarmonyOS操作系统
5. 应用简介：一个基于鸿蒙系统的 AI 对话助手，支持用户输入消息，并调用 AI 接口返回智能回复，旨在提供便捷的、仿真的对话体验。
6. UI层架构：使用Row、Column、Flex、Scroll、TextInput、Image等组件
7. 逻辑层：处理用户输入，根据输入请求 AI 接口并返回数据，再加以渲染
8. 数据层：调用云端 AI 接口，进行数据处理；使用本地持久化存储方案。

## 模块划分：
1. **对话管理模块**：负责管理用户消息和 AI 回复的逻辑。
2. **AI接口模块**：调用 AI 接口并处理返回promise异步请求结果。
3. **数据存储模块**：基于本地持久化存储，存储用户会话数据和历史记录。

## 演示视频：
[点击观看视频](https://github.com/kaikaiGit/chatAI/blob/main/chatAI_effect.mp4)
<video width="560" height="315" controls>
  <source src="https://github.com/kaikaiGit/chatAI/blob/main/chatAI_effect.mp4" type="video/mp4">
  您的浏览器不支持视频标签。
</video>


---
title: grub和rEFInd——配置你的双系统
categories: 瞎折腾的日常
mathjax: false
date: 2019-07-29 21:45:36
tags: [grub, rEFInd, 引导, 双系统, bilibili]
---

# 写在前面

因为大家似乎对双系统特别感兴趣，所以先做一期这个视频好啦～视频链接戳[这里](https://www.bilibili.com/video/av61364115/)

![先上图再说](grub&rEFInd_config_your_hybrid_system/rEFInd引导界面.png)

![b站小伙伴投票](grub&rEFInd_config_your_hybrid_system/b站小伙伴投票.png)

顺便庆祝一下我的b站播放量过万啦嘻嘻嘻

![播放量破万留恋](grub&rEFInd_config_your_hybrid_system/播放量破万留恋.png)

<!-- more -->

# 提示

这篇博客需要配合上面提到的视频一起食用，仅限UEFI启动方式喔～

视频主要讲了一下内容：

- [x] 简述视频和介绍要讲的芝士点 0:00
- [x] 系统引导背景资料 4:30
- [x] 引导分区详细内容 14:53
  - [x] rEFInd与grub
  - [x] windows引导
- [x] rEFInd安装与配置 30:04
  - [x] 安装 30:04
  - [x] efibootmgr 42:20
  - [x] 配置 45:40
  - [x] grub设置timeout 59:43
- [x] 个人配置链接以及下期预告 1:06:22

话说cpu渲染可是真的不够给力

![](grub&rEFInd_config_your_hybrid_system/1564424097425.png)

# 系统引导背景知识


- 分区表

  - mbr
    - 512B
    - 1-4主分区
    - 拓展分区

  - gpt
    - 128分区

- mbr+BIOS

  - 过场很复杂blabla
  - windows 7

- gpt+EFI

  - 好看多功能引导界面
  - EFI分区
  - rEFInd

![引导分区](grub&rEFInd_config_your_hybrid_system/1564425345912.png)

# grub相关

`/etc/default/grub`

`/etc/grub.d`

`/boot/grub/grub.cfg`

第三个才是生效的大boss，前两个通过`grub-update`命令会被整合到第三个文件中。

# 引导知识

引导分区一般挂载在`/boot/efi/EFI`目录下，用来引导操作系统，rEFInd是一个第三方引导，以简洁的外观和可定制化的配置著称。

![再来一次～](grub&rEFInd_config_your_hybrid_system/rEFInd引导界面.png)

# 安装

安装过程非常简单  `./refind-install`就好啦～

要好看的话记得把我的配置覆盖一下ho～

手动安装的小伙伴记得`efibootmgr`配置喔～

别忘了设置grub的timeout ho～

# 相关链接

原版rEFInd下载：[点我](refind-bin-0.11.4.zip)

配置下载：[click me](refind-theme.zip)
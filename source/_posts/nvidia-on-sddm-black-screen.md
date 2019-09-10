---
title: 在manjaro-kde上nvidia开机黑屏解决办法
tags: [sddm, 黑屏, nvidia, tty, manjaro, kde]
categories: 瞎折腾的日常
mathjax: false
date: 2019-08-15 13:47:01
---

# 写在前面

有幸搞到并配置了一台i7-2600K、GTX 1080ti的机器（是不是很不协调），安装了我熟悉的manjaro(kde平台)却在安装好重启后却在进入桌面环境之前一直**黑屏**，切换一下tty后linux就又能正常进入kde，且进入后的系统完全没看出来是显卡驱动的问题。

这篇来讲讲怎么解决。

<!-- more -->

# 问题描述

通过不断测试，发现

- 在确保安装了开源驱动的情况下系统能够正常进入到登录界面
- 在安装了闭源驱动后无法正常进入登录界面，但尝试切换tty(`ctrl+alt+fx`)两次后，在短暂的黑屏引导后能正常进入登录界面

# 问题解决

女票太强了，找到了解决问题的[帖子](https://www.reddit.com/r/archlinux/comments/91p0dv/sddm_doesnt_show_up_unless_i_switch_ttys/)（不得不说学好英文很重要）。中文基本上搜不到相关的问题。唯一找到的看上去情况类似的[帖子](https://www.jianshu.com/p/694cd939e80e)并不能解决问题（KMS并不是问题的关键）。

故特此记录如下：

**问题本身出在sddm上**，熟悉各类DM的可以试试把sddm关掉使用其他DM比如lightdm；或者关闭sddm的自动启动，然后在tty下手动启动sddm都能解决问题。

根据reddit上网友的描述，这个问题在[github](https://github.com/sddm/sddm/issues/1036)上有提过issue，通过使用rng-tools来解决这类熵问题(entropy issue)。我猜测应该是sddm引导nvidia闭源驱动来启动的时候需要使用一些随机数来完成其加密功能（吧），而众所周知很多随机信息的引入都是依靠外部媒介（比如键盘、鼠标输入等），所以切tty有用。

所以知道了问题，解决起来就很方便了。

```shell
yay -Sy rng-tools #安装rng-tools
sudo systemctl enable rngd.service # 开机自启动rng-tools
```

这两行搞定后重启应该就能解决问题啦。


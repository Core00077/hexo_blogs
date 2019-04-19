---
title: Linux截屏神器——Flameshot
mathjax: false
date: 2019-04-18 19:35:38
tags: [安利,linux,flameshot,截屏]
categories: 瞎折腾的日常
---

# 写在前面

最近写安利文似乎真写的有点多了hhh，那就再来一篇吧。

这篇来讲Linux下好用的截屏软件～

先放图：

![预览图](Linux截屏神器——Flameshot/animatedUsage-1555587408765.gif)

<!-- more -->

# 特点

看动图就知道有不少的功能啦～这张图来自[其github官网](<https://github.com/lupoDharkael/flameshot>)，当前版本还有新增了很多操作：

- 模糊块
- 浮动图层
- 添加文字
- 在不同的应用中打开

# 解决了我的痛点

flameshot给我解决的最大痛点就是：**复制到剪贴板**

老实说，之前查linux下好用的截图软件全是清一色的深度截图。怎么说呢？深度截图其实确实很用心也做了很多功能。可不知道为什么manjaro+KDE下就是[无法复制到剪贴板](<https://github.com/linuxdeepin/developer-center/issues/1091>)。

当然深度截图还有一些小bug——比如马赛克/模糊功能，[在双屏下其马赛克的部分始终来自屏幕1](<https://github.com/linuxdeepin/deepin-screenshot/issues/18>)。

而flameshot则是爽的很，从安装到使用，丝滑～

# 安装

关于如何安装我就直接摘抄github仓库上的教程啦

> Installation
>
> There are packages available for a few distros:
> - Arch: `pacman -S flameshot`
>   - Snapshot also available via AUR: [flameshot-git](https://aur.archlinux.org/packages/flameshot-git).
>
> - Debian 10+:`apt install flameshot`
>
>   - Package for Debian 9 ("Stretch") also [available via stretch-backports](https://backports.debian.org/).
>
> - [Ubuntu 18.04+](https://launchpad.net/ubuntu/+source/flameshot): `apt install flameshot`
>
> - [openSUSE](https://software.opensuse.org/package/flameshot)
>
> - [Void Linux](https://github.com/void-linux/void-packages/tree/master/srcpkgs/flameshot) (`xbps-install flameshot`)
>
> - [Docker](https://github.com/ManuelLR/docker-flameshot)
>
> - Fedora: `dnf install flameshot`
>
> - [Snap/Flatpak/AppImage](https://github.com/flameshotapp/packages)
>
> - Besides, generic packages available via [opensuse software repository](https://software.opensuse.org//download.html?project=home%3AVitzy&package=flameshot)

# 使用

第一次使用的时候启动之后它会一直待在托盘里，右键设置就可以看到啦，然后可以记得给它设置一个快捷键。

当然命令行操作也很容易，官网上提供了，就不赘述。
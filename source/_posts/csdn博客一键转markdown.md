---
title: csdn博客一键转markdown,还附带hexo头(yaml matter)！
mathjax: false
date: 2019-04-06 21:40:07
tags: [csdn,markdown,hexo]
categories: 瞎折腾的日常
---

# 前言

csdn有些地方是真的难用，最近越来越难用了。之前吞了我的博客（当然怪我自己没备份啦），后来想了想觉得其可定制性的确有限，而且很多功能并不支持，再加上阅览了一些hexo神器的文章，就果断选择了自己搭建个人博客了。

其实搭建hexo之前我就把csdn上的博客都弄下来了，因为之前**沉迷搭建博客**和各种**好玩的组件**，所以现在才想起来要写这篇博客，见谅见谅。

更多和搭建hexo博客相关的内容，请在左侧导航栏中的`标签`或文章底部，点击`hexo`标签即可看到所有相关文章。 :smile: 感谢阅读。

## 此博客作用

帮助快速将之前写在csdn上的所有**markdown**格式的blog以md格式导出。

这是我在github上找到的一个开发者写的爬虫，原理上是用自己的cookie信息去csdn上把自己的文章爬下来。因为作者写的比较久远，csdn上的接口已经更换了，我做了一些调整并基本可以使用，pr过去了，已经被作者merge到原仓库[^merge]。

[^merge]: [修复了一些csdn更改了的接口和html元素，亲测可以正常使用](<https://github.com/secsilm/csdn2md/pull/1>)

<!-- more -->

引用一下原作者的readme以及作者仓库[^作者仓库]

> Export csdn blogs to markdown files.
>
> 一个用于将 csdn 博客导出为 markdown 文件的程序。
>
> 为了将自己的 csdn 博客文件导出放到我的 [hexo 站点](https://secsilm.github.io/)上， 我写了这个程序来导出文件，并加上 hexo 所需要的头部说明（title、date 等等）。
>
> 我收集了很多 UA 放在 `uas.txt` 文件中，当然这个程序用不到那么多。
>
> 你需要先在网页上登录自己的 csdn 博客，然后把 cookies 复制到 `cookies.txt` 文件里。
>
> 需要注意的是如果你当初写博客的时候不是用 markdown 编辑器写的，那么这个程序是不支持的。
>
> Good luck，CSDN sucks。

[^作者仓库]: [Export csdn blogs to markdown files.](<https://github.com/secsilm/csdn2md>)

# 使用

在[作者博客](<https://alanlee.fun/2017/12/25/export-csdn-blogs-to-md/>)的文章里，这个小爬虫原理已经写的很清楚了，这边不赘述。因为作者readme里没有写installation和usage，帮助其补充一下好了。

## installation

```shell
git clone https://github.com/secsilm/csdn2md.git
```

直接克隆到某个目录里就好了

因为作者没有写requirements.txt，补充一下需要的额外依赖：

```
requests==2.21.0
fire==0.1.3
beautifulsoup4==4.7.1
```

## usage

其实我很喜欢作者这种言简意赅、**cheap in talk, talk in code**的大佬。基本上代码一看你就懂是怎么回事，所以很修改和调试。

首先去csdn上登录自己的帐号，浏览器开发模式把完整的cookie搞下来放在cookies文件里。

然后……啊作者原博客上（包括源码里）其实写了用法

> Type:        function
> String form: <function to_md_files at 0x000001CACC8C5E18>
> File:        d:\chromedownload\mdfiles\csdn2md.py
> Line:        47
> Docstring:   导出为 Markdown 文件。
>
> Args:
>     total_pages: 博客文章在摘要模式下的总页数
>     filename: 含有 cookies 字符串的 txt 文件名
>     start: 从 start 页开始导出 (default: {1})
>     stop: 到 stop 页停止 (default: {None})
>     hexo: 是否添加 hexo 文章头部字符串（default: {True}）
>     md_dir: md 文件导出目录，默认为当前目录（default: .）
>
> Usage:       csdn2md.py USERNAME TOTAL_PAGES COOKIE_FILE [START] [STOP] [HEXO] [MD_DIR]
>              csdn2md.py --username USERNAME --total-pages TOTAL_PAGES --cookie-file COOKIE_FILE [--start START] [--stop STOP] [--hexo HEXO] [--md-dir MD_DIR]

还都是中文，爽到。

总之，在我写好cookie之后，我就console里直接

```shell
python3 csdnmd.py Core00077 2 ./cookies.txt
```

就完事儿。

# 最后

感谢大佬开源，感谢github，开源运动真的帮助我们减少了大量重复性的工作。太棒了。

最后非常赞同作者的那句话：

> Good luck, csdn sucks.


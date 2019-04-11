---
title: 物体检测算法YOLOv3的改进——毕设题目
mathjax: false
date: 2019-04-11 13:00:00
tags: [毕业设计,yolo,yolov3,目标检测]
categories: 课业文档
---


# 设计（论文）主要内容

1. 前期知识储备：

   首先深入学习并理解物体检测算法YOLOv3，掌握物体检测的任务、方法与评价指标，理解YOLOv3算法所使用的主干网（backbone network）、bounding box priors、bounding box分类与定位等技术细节。

2. 系统功能：

   ​      针对自动驾驶数据集BDD100k，改进YOLOv3算法，提高算法在此数据集上的物体检测性能。应基于对BDD100k数据集中bounding box大小的分布，确定适合此数据集的bounding box priors；基于数据集中物体位置的分布特征，确定合适的检测策略；基于对不同类别物体的分布特征分析，逐类别提高算法的检测性能（可选）；设计合适的输入预处理方法，充分利用图像的高分辨率提高算法的物体检测性能；设计对夜景图像的有效处理方法（可选）。

3. 文档：

   ​      完成YOLOv3改进算法的设计、编码实现及调试、测试、分析工作后，应提供相应的算法设计、实现与分析文档。

<!-- more -->

# 完成的主要任务及要求

1. 针对自动驾驶数据集BDD100k，改进YOLOv3算法。应对所实现的改进算法进行详细的实验分析。
2. 算法开发语言为C++。
3. 算法的文档应能详细、准确地反映算法的设计思想。文档格式应尽可能规范，易读易懂，叙述问题准确。
4. 要求按武汉理工大学理工类本科生毕业论文撰写规范撰写毕业论文，论文字数不少于12000字，参考文献不少于15篇，其中英文文献不少于2篇；学生提交论文同时，上交存储所设计系统和英文资料翻译文档、论文的软盘片或光盘片，英文翻译不少于5000字。
5. 实现的算法至少要完成的基本功能模块：图像特征抽取模块、物体检测模块、结果显示模块、检测结果评价模块。
6. 遵守毕业设计的纪律，每周向指导教师汇报毕业设计有关情况，并按时撰写毕业设计周记。

# 完成任务的时间节点

1. 2019/1/19—2019/2/28；确定选题，查阅文献，外文翻译和撰写开题报告；
2. 2019/3/1—2019/4/30；系统架构、程序设计与开发、系统测试与完善；
3. 2019/5/1—2019/5/25；撰写及修改毕业论文；
4. 2019/5/26—2019/6/5。准备答辩。

# 必读参考文献

1. J. Redmon and A. Farhadi, “YOLOv3: An incremental improvement”. arXiv preprint arXiv:1804.02767, 2018.
2. Redmon and A. Farhadi, "YOLO9000: Better, Faster, Stronger," *2017 IEEE Conference on Computer Vision and Pattern Recognition (CVPR)*, Honolulu, HI, 2017, pp. 6517-6525.
3. J. Redmon, S. Divvala, R. Girshick and A. Farhadi, "You Only Look Once: Unified, Real-Time Object Detection," 2016 IEEE Conference on Computer Vision and Pattern Recognition (CVPR), Las Vegas, NV, 2016, pp. 779-788.
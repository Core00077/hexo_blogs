---
title: manjaro (arch)安装完成后重启报错：Root device mounted successfully, but sbininit does not exist
date: 2018-12-24 09:45:13
tags: [manjaro,arch linux,linux]
categories: 瞎折腾的日常
---


# 前言

这个问题是我的大佬同学赖拐发现的，估计也有很多和他一样被鸟叔带入门linux的童鞋吧？哈哈，只能说实在可惜第三版出的时间太过久远（八年前），据说第四版已经出啦（今年十一），大家有能力去支持一下吧～

# 问题

言归正传，错误应该是在我们开开心心装好manjaro之后重启，本以为可爱的plasma-kde出现，结果出来了黑不溜秋的报错提示：

```shell
ERROR: Root device mounted successfully, but /sbin/init does not exist.

sh:can't access tty; job control turned off

[rootfs /]#
```

<!-- more -->

**实际上真正的原因是我们把/usr挂载在了单独的分区上。**具体的原因可以参考[stackexchange](https://unix.stackexchange.com/questions/139802/error-root-device-mounted-successfully-but-sbin-init-does-not-exist)的一篇问答，很有价值。这里稍作引用

>   As @Leiaz very correctly pointed out in the comments, `/sbin` in Arch (and by extension, Manjaro) is now a symlink to `/usr/bin`. This means that unless `/usr` is mounted, `/usr/sbin/init` will not exist. You therefore need to make sure that `/usr` is mounted by the initial ramdisk. That's what the Arch wiki quote in your OP means:
>
>   >   If you keep /usr as a separate partition, you must adhere to the following requirements:
>   >
>   >   -   Enable mkinitcpio-generate-shutdown-ramfs.service or add the shutdown hook.
>   >   -   Add the fsck hook, mark /usr with a passno of 0 in /etc/fstab. While recommended for everyone, it is mandatory if you want your /usr partition to be fsck'ed at boot-up. Without this hook, /usr will never be fsck'd.
>   >   -   Add the usr hook. This will mount the /usr partition after root is mounted. Prior to 0.9.0, mounting of /usr would be automatic if it was found in the real root's /etc/fstab.
> 

**白话文**就是：开机的时候需要访问/sbin/init下的文件，但是这个文件不存在。因为arch及其衍生版对于从前老式的/sbin, /bin, /lib的处理是直接用一个链接指向/usr/sbin, /usr/bin, /usr/lib，但是刚开机的时候，你的/usr（因为是单独的分区）还没有挂载上去呢～

如果想多理解一些的话，建议参考一下我的另一篇博客，在[Manjaro安装配置小记](https://blog.csdn.net/Core00077/article/details/85229095)里有详细解释为什么ubuntu、debian这类系统可以单独把/usr分出来（主要是一些历史遗留问题）。

----

# 怎么办？

### 不把`/usr`分出来，保持其和根目录在一起

解决方案很直接，直接的办法就是不要把/usr单独分出来，保持它和根目录在一起就好。

不过能看到这个帖子的人至少应该是尝试过把/usr单独分出来的，那这里稍微讨论一下把/usr单独分出来的必要性：

#### 先说说为什么要分出来：

装系统的时候分区是个技术活，而一般来说我们都会把这些挂载点单独分区分出来，依据是FHS的标准建议：`根目录所在分区应该越小越好，且应用程序所安装的软件最好不要与根目录放在同一个分区内。保持根目录越小越好。如此不但性能较好，根目录所在的文件系统也较不容易发生问题`

翻译一下就是你系统出问题的时候，可以保护其他部分的数据。

>   根据鸟叔的linux私房菜第三版和个人经验：
>
>      -   /
>      -   /tmp
>      -   /boot
>      -   /usr
>      -   /home
>      -   /var
>      -   SWAP
>      -   /opt
>      -   ….
>

鸟哥的私房菜和一些教程，以及一些历史原因的确成为了大多数把/usr分出来的人的理由，像对用户比较友好的ubuntu、debian发行版也的确保留了/bin，/sbin这些目录，但是对于激进的arch及它的衍生发行版就不这么想了，毕竟这些实属历史遗留的目录，**arch设计的宗旨是完全可定制化轻量级的操作系统**，所以就二话不说移走了。

#### 不分出来的理由是这样的：

先引用一段[v2ex](https://www.v2ex.com/t/189944)上的评论：

>   ​    **algas**   2015-05-10 19:21:02 +08:00
>
>   /usr单独分出来没有什么必要，我甚至觉得这样做有副作用。重装系统的时候，如果安装的系统版本高于之前的，/usr/lib之类的东西都应该覆盖，而不是直接挂在/usr（大概是这样的）。倒是/usr/local/比较推荐单独分区。虽然opt是设计给第三方软件的，但是opt并没有默认的bin目录，而且很多软件默认就选择了/usr/local位置，所以，是吧。

我对这个解释是比较认可的，就好像现在windows上的office、腾讯qq这些即使你按在了D盘，C盘重装之后还不是得重新安装这些软件，因为像注册表啊依赖啊这些东西C盘里的都没了嘛，去补这个那个还不如重新安装来的简单快捷。/usr下的东西也是同理可得，即使分出来了，许多依赖还没有的话，也是一样需要reinstall，那干脆和/一起重装得了。

另一个石锤是鸟叔在2018-10-01出的[linux私房菜第四版](https://wizardforcel.gitbooks.io/vbird-linux-basic-4e/content/21.html)里也不再把/usr单独划分出来，推荐划分的只有下面5个。

![](manjaro_(arch)安装完成后重启报错：Root_device_mounted_successfully,_but_sbininit_does_not_exist/20181224094224979.png)

我的分区方案是：
- /boot
- /boot/efi
- SWAP
- /
- /opt
- /var
- /home
- /tmp

如果有多系统的话，还需要把/boot/efi挂载到之前系统的引导分区里（仅限UEFI），**一个详细的分区方案及介绍**可以参考我的一篇博客[Manjaro安装配置小记](https://blog.csdn.net/Core00077/article/details/85229095)

### 依然想把`/usr`分出来

这个方案我个人没有去实施，毕竟有点难度，需要考虑引导、hook之类的东西，其实原理上主要是一下两种：

-   提前把/usr下的一些东西提前挂上去
-   或者是考虑直接把/usr/sbin这类软链接删除掉，然后把/usr下的拷出去

这里提供[stackexchange](https://unix.stackexchange.com/questions/139802/error-root-device-mounted-successfully-but-sbin-init-does-not-exist)大佬参考manjaro提供的解决方案

>   So, you need to generate a new init file with the right hooks1. These are added by changing the `HOOKS=""` line in `/etc/mkinitcpio.conf`. So
>
>   1.  Boot into Mint and mount the Manjaro `/` directory:
>
>       ```
>       mkdir manjaro_root && sudo mount /dev/sda11 manjaro_root
>       ```
>
>       Now, Manjaro's root will be mounted at `~/manjaro_root`.
>
>   2.  Edit the `mkinitcpio.conf` file using your favorite editor (I'm using `nano` as an example, no more):
>
>       ```
>       sudo nano ~/manjaro_root/etc/mkinitcpio.conf
>       ```
>
>       Find the `HOOKS` line and make sure it contains the relevant hooks
>
>       ```
>       HOOKS="shutdown usr fsck"
>       ```
>
>       **Important**" : do not remove any of the hooks already present. Just add the above to those there. For example, the final result might look like
>
>       ```
>       HOOKS="base udev autodetect sata filesystems shutdown usr fsck"
>       ```
>
>   3.  Mark `/usr` with a passno of 0 in `/etc/fstab`. To do this, open `manjaro_root/etc/fstab`and find the `/usr` line. For this example, I will assume it is `/dev/sda12` but use whichever one it is on your system. The "pass" number is the last field of an `/etc/fstab` entry. So, you need to make sure the line looks like
>
>       ```
>       /dev/sda12  /usr  ext4  rw,errors=remount-ro     0      0
>                                                               ^
>                                This is the important one -----|
>       ```
>
>   4.  Create the new init image. To do this, you will have to mount Manjaro's `/usr` directory as well.
>
>       ```
>       sudo mount /dev/sda12 ~/manjaro_root/usr
>       ```
>
>       I don't have much experience with Arch so this might not bee needed (you might be able to run `mkinitcpio` without a `chroot`) but to be on the safe side, set up a `chroot` environment:
>
>       ```
>       sudo mount --bind /dev ~/manjaro_root/dev && 
>       sudo mount --bind /dev/pts ~/manjaro_root/dev/pts && 
>       sudo mount --bind /proc ~/manjaro_root/proc && 
>       sudo mount --bind /sys ~/manjaro_root/sys &&
>       sudo chroot ~/manjaro_root
>       ```
>
>       You will now be in a chroot environment that thinks that `~/manjaro_root/` is actually `/`. You can now go ahead and generate your new init image
>
>       ```
>       mkinitcpio -p linux
>       ```
>
>   5.  Exit the `chroot`
>
>       ```
>       exit
>       ```
>
>   6.  Update your `grub.cfg` (again, this might not actually be needed):
>
>       ```
>       sudo update-grub
>       ```

<u>不过我都没实际操作，要是有感兴趣的小伙伴实施了可以给我反馈一下嘻嘻嘻。</u>

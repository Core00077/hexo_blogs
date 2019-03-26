---
title: 获取form-data的数据——apache.commons.fileupload
date: 2017-12-30 12:06:38
tags: [java,form-data,文件上传,http请求,post请求]
categories: 学习笔记
---

# [travel.corechan.cn](http://travel.corechan.cn)
最近刚入门java后台，用原生java写的项目，记录一下其中遇到的问题以及解决——图片上传。

<!-- more -->

# post方法详细
## 概述
不知道现在技术最常用的方案是啥，我看了许多文章才知道，原来我用了这么多的post方法接数据，其实post上传数据光是格式就有许多种：

- application/x-www-form-urlencoded
- multipart/form-data
- application/json
- text/xml

这个是参考大佬的博客看到的：[四种常见的POST提交数据方式](https://imququ.com/post/four-ways-to-post-data-in-http.html) 写的很详细。

看了这篇文章我才知道原来之前我没管前端的哥们儿发的啥，我都是用req.getParameter("")接的数据，能接到数据而且甚至不用decode就能正常显示也不是没道理的，post请求默认就是发的x-www-form-urlencoded。文字就说了encoded咯。

###form-data实战
首先感谢另一位大佬关于form-data的讲解：
[Java中，当表单含有文件上传时，提交数据的如何读取](http://blog.csdn.net/lian_zhihui1984/article/details/6822201)

这里使用了apache.commons.fileupload.jar的包，据说是比较常用的方案。如果想了解不引包怎么解决问题，我这篇博客没啥用。
>不引包的话需要在request.getInputStream，然后去解析数据流，自己造轮子比较容易出错，在这里表示不推荐。

具体操作我写了个demo，注释比较详细
```java
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

@WebServlet(urlPatterns = "/test")
public class TestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    //允许跨域访问
        resp.setHeader("Access-Control-Allow-Origin","*");
        //设置各种过滤器
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("UTF-8");
        //输出请求的类型
        System.out.println(req.getContentType());
        //这一段是获取参数并且输出参数名和值，用的是常规方法
        Enumeration<String> parameterNames = req.getParameterNames();
        resp.getWriter().println("------这是parameter部分------");
        while (parameterNames.hasMoreElements()) {
            String name = parameterNames.nextElement();
            resp.getWriter().println(name + "\t" + req.getParameter(name));
        }
        //处理form-data
        boolean isMultipart = ServletFileUpload.isMultipartContent(req);
        //首先要new一个专门生产FileItem的工厂，fileitem是通过调包解析请求数据后，数据存储的对象
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //设置临时文件大小（有时候可能传的文件太大，需要使用临时文件）
        factory.setSizeThreshold(1024 * 1024);
        //设置临时文件存放的位置
        factory.setRepository(new File("testcore"));
        //工厂相关的参数设置完成后，以工厂为模版，new一个upload实例
        ServletFileUpload upload = new ServletFileUpload(factory);
        if (isMultipart) {
            try {
	            //用upload实例解析request，并将解析的结果放在List<FileItem>里面
	            //每一个FileItem实际就是form-data中的键值对
                List<FileItem> items = upload.parseRequest(req);
                resp.getWriter().println("------这是form-data部分------");
                //遍历items
                for (FileItem item : items) {
	                //判断当前item是不是表单域（也就是表单域中的文字信息）
                    if (item.isFormField()) {
	                    //获取这个键值对的键和值，并输出
                        String name = item.getFieldName();
                        String value = item.getString();
                        resp.getWriter().println(name + "\t" + value);
                    } else {
	                    //如果不是表单域，则说明这是个文件，获取文件的相关信息并输出
                        String name = item.getName();
                        String field = item.getFieldName();
                        long size = item.getSize();
                        String type = item.getContentType();
                        String url = "/testcore/" + name;
                        resp.getWriter().println(field + "\t" + type + "\t" + size + "b\t" + url);
                        //既然已经拿到文件了（文件在内存里），那么就把它写到硬盘里吧
                        File file = new File(getServletConfig().getServletContext().getRealPath("testcore"), name);
                        if (!file.getParentFile().exists()) {
                            if (file.getParentFile().mkdir())
	                            //写入硬盘
                                item.write(file);
                        } else
	                        //写入硬盘
                            item.write(file);
                        //打印文件在硬盘里的绝对路径
                        System.out.println(file.getAbsolutePath());
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
```

# 总结
form-data有几个要注意的点：

- form-data发到后台上的数据是不会帮你encode的，毕竟文件就是二进制流，完全没有encode的必要性。所以在form-data里发文字之前请前端的同学先urlencode一下
- java后台处理文件内容，如果保存的位置需要新建文件夹，记得要先mkdir，不然会尴尬的报错“找不到文件位置”，具体来说就是这样，先是错误的示范：
```java
//错误的示范
//假设我文件要存在后台根目录的testcore文件夹下的savepath文件夹中，以savename为文件名
File file=new File("/testcore/"+savepath,savename);
fileItem.write(file);
```
```java
//正确的示范
File file=new File("/testcore/"+savepath,savename);
//先判断存这个文件的目录存不存在，存在就好咯，直接写入硬盘
if(file.getParentFile.exist())
	fileItem.write(file);
else
	//如果不存在，就创建这个目录，如果创建成功，就写入硬盘
	if(file.getParentFile.mkdir())
		fileItem.write(file);
	//万一创建不成功……就抛出异常什么的，这个就自行处理吧
```

# 撒花完结
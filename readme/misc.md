---
## ubuntu下有道词典不能取词
https://blog.csdn.net/linmingan/article/details/83376490

在shell终端驱动youdao-dict后进行屏幕取词翻译，显示如下错误
```
QOpenGLShaderProgram::uniformLocation( qt_Matrix ): shader program is not linked
```

经过调查发现是有道词典找不到显卡驱动问题。
在`/etc/ld.so.conf.d`中的`x86_64-linux-gnu_GL.conf`中可以发现有显卡驱动安装目录，通过下面的命令可以查看:
```
$ cd /etc/ld.so.conf.d
$ cat x86_64-linux-gnu_GL.conf
>>>
/usr/lib/nvidia-340
/usr/lib32/nvidia-340
```

查看i386-linux-gnu_GL.conf，发现是空的。只要将x86_64-linux-gnu_GL.conf的内容复制到i386-linux-gnu_GL.conf就可以。具体如下:
```
sudo cp x86_64-linux-gnu_GL.conf  i386-linux-gnu_GL.conf
sudo ldconfig
```

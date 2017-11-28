# Python Environment

# Hobot Mxnet
## Build
### Ubuntu
Building "hobot-mxnet"
requires to link
"hobot_core.a", which may inculdes "densebox" plugin. In the
"densebox_vm"
branch of "hobot-mxnet", "densebox" also exists as a plugin. So
that you should
make sure the both of two "densebox" plugins link to **same
opencv lib**.

The
"hobot_core.a" on the artifactory was build on Centos and
linked to an unknow
opencv version. So you need to rebuild "hobot_core.a" on
your Ubuntu system.
Refer to **Chapter Hobot_core** in this Readme. After
rebuilding "hobot_core.a",
you need to copy "include" and "lib" intp the "deps"
folder in the hobot-mxnet.
## Pre-build Versions
### hobot-mxnet.densebox_vm

```{.python .input}
%%bash
export PYTHONPATH=/home/austin/Public/pre-compiled/hobot-mxnet.densebox_vm.20171116/python:$PYTHONPATH
export LD_LIBRARY_PATH=/home/austin/ubuntu-lib/cv3.2_1/lib:$LD_LIBRARY_PATH
```

# Hobot_core
http://ph.hobot.cc/diffusion/HABCS/

```{.python .input}
$ git clone
ssh://git@ph.hobot.cc/diffusion/HABCS/hobot-algorithm-base-code-source.git
$ git
submodule init
$ git submodule update
$ cp config.mk.example config.mk
# Enable
"HOBOT_CORE_MODULE += module/densebox/densebox.mk" in "config.mk"
$ make
$ make
dist 
```

# History

## 2017-11-20

```{.python .input}
ll /usr/include/x86_64-linux-gnu/cudnn_v6.h
ll
/usr/include/cudnn.h
ll /usr/lib/x86_64-linux-gnu/libcudnn.so.6.0.21
ll
/usr/lib/x86_64-linux-gnu/libcudnn.so
ll /usr/lib/x86_64-linux-
gnu/libcudnn_static_v6.a
ll /usr/lib/x86_64-linux-gnu/libcudnn.so.6
ll
/usr/lib/x86_64-linux-gnu/libcudnn_static.a
ll /usr/share/doc/libcudnn6
ll
/usr/share/doc/libcudnn6-dev
ll /usr/share/lintian/overrides/libcudnn6
ll
/usr/share/lintian/overrides/libcudnn6-dev

sudo rm -r
/usr/include/x86_64-linux-gnu/cudnn_v6.h
sudo rm -r /usr/include/cudnn.h
sudo rm
-r /usr/lib/x86_64-linux-gnu/libcudnn.so.6.0.21
sudo rm -r
/usr/lib/x86_64-linux-gnu/libcudnn.so
sudo rm -r /usr/lib/x86_64-linux-
gnu/libcudnn_static_v6.a
sudo rm -r /usr/lib/x86_64-linux-gnu/libcudnn.so.6
sudo
rm -r /usr/lib/x86_64-linux-gnu/libcudnn_static.a
sudo rm -r
/usr/share/doc/libcudnn6
sudo rm -r /usr/share/doc/libcudnn6-dev
sudo rm -r
/usr/share/lintian/overrides/libcudnn6
sudo rm -r
/usr/share/lintian/overrides/libcudnn6-dev
```

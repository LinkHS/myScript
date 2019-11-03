# Shell

## rsync

Example copy all with exclusion: 

```shell
rsync -aP --exclude=x --exclude=y /folder1/* /folder2/
```

> a: Similar to cp -a, recursive, etc.
> P: Shows progress, a nice feature of rsync.

# 快捷键

"ctrl+;": 显示历史复制命令
"cmd+w": 预览所有非最小化窗口
"cmd+tab": 从系统边栏选择应用
"alt+\`":

---
# 系统问题

## 解决双系统无法访问windows硬盘
1. 查看硬盘挂载情况
`sudo fdisk -l`

2. 修复相应分区
`sudo ntffix /dev/sda5`

## 查看动态运行库

```shell
ldd *.bin|so

readelf -d $executable | grep 'NEEDED'

ldconfig -p | grep cudnn
```

---
# Others
## VPN or Proxy
```shell
export http_proxy=http://<username>:<password>@10.191.131.3:3128
export https_proxy=http://<username>:<password>@10.191.131.3:3128
```

---
## 查看GPU状态
``` shell
pip install gpustat

gpustat -cpu
# or
watch --color -n 1 gpustat -cpu
```

---

# DeepLearning

## Tensorboard

```shell
tensorboard --logdir name1:/path/to/logs/1,name2:/path/to/logs/2
```

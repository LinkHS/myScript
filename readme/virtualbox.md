
---
## USB 设备
1. VirtualBox 使用宿主机的USB设备需要安装扩展包 Extension_Pack。根据自己的vbox的版本，到vbox官网下载对应的扩展包。下载完毕后，在“管理”菜单下的“全局设定”里的“扩展”标签下，安装。

2. 安装完后还需要将当前用户加入到 VirtualBox 的用户组里。
```
# 查看 vbox 的用户组命
cat /etc/group | grep vbox

sudo usermod -a -G vboxusers austin
```

3. 重启宿主机。

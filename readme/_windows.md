# 常用软件

## 福昕阅读器

### 打开之前关闭的全部文件

在”偏好设置“里找到”历史记录“，选中”启动时打开上次会话“ 

---

## Totalcmd

### 添加快速启动程序-日历

```
Command: outlookcal:

Icon file: "C:\Program Files\Microsoft Office\root\vfs\Windows\Installer\{90160000-000F-0000-1000-0000000FF1CE}\outicon.exe"
```

---

# 其他

## 路由表
使用expressvpn时候，即使用了它的split channel功能指定只允许chrome走vpn，但是学校的服务器还是会被expressvpn阻止。此时可以修改路由表让服务器不走vpn通道。用`route print`或者`ipconfig`命令可以看到复旦校园网的网关地址为`10.222.128.1`。

1. 临时添加
```powershell
route add 10.141.221.153 mask 255.255.255.255 10.222.128.1
route add 10.141.221.154 mask 255.255.255.255 10.222.128.1

route add 10.141.221.0 mask 255.255.255.0 10.222.128.1
```

2. 永久添加
```powershell
# `-p` 表示永久添加，即重启后也还在
# `metric 1` 表示优先级，数字越低优先级越高
route -p add 10.141.221.0 mask 255.255.255.0 10.222.128.1 metric 1
```

3. 删除
```powershell
route delete 10.141.221.154
```

---

## 任务栏某个应用程序图标变白

1. 同时按下快捷键`Win+R`，在打开的运行窗口中输入`%localappdata%`，回车
2. 在打开的文件夹中，找到隐藏的`Iconcache.db`，将其删除
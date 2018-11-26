---
## winetricks
```
cd "${HOME}/Downloads"
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
```

```
sh winetricks corefonts vcrun6 
```

---
## win32 程序
```
export WINEPREFIX="/home/austin/.wine32"
export WINEARCH="win32"
export LC_ALL=zh_CN.UTF-8
```


--- 
## 中文显示
若你的系统不是中文界面，请添加以下代码至桌面的wehcat的属性栏
```
env LC_ALL=zh_CN.UTF-8
```


---
## 微信
[WeChat](https://appdb.winehq.org/objectManager.php?sClass=version&iId=36573)
```
winetricks msls31 ole32 riched20 
```

---
## Reference
- [wine 安装使用记录](https://www.jianshu.com/p/6aa175a534c4)
- [wine wiki](https://wiki.archlinux.org/index.php/Wine_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))


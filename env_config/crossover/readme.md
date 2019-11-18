
# 问题
## 微信/百度网盘输入框无法显示文字
```shell
cp ./riched20.dll $HOME/.cxoffice/WinXP/drive_c/windows/system32
```

## WeChatWin.dll丢失
```
sudo apt-get install libldap-2.4-2:i386
```

## 字体
```
cp SynologyDrive/Softwares/Plugin/winxp_fonts/* /opt/cxoffice/share/wine/fonts/
```

## 中文字体乱码

```
vim ~/.v
```
[EnvironmentVariables]
```
"LANG" = "zh_CN.UTF-8"
```

## 图标错乱
检查`/home/austin/.local/share/icons/wine.png`

## 延长使用
```shell
# rm ~/.cxoffice/容器名称/.eval
rm  ~/.cxoffice/WinXp/.eval
```
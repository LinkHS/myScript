## 查看安装位置

If you are asking where the files in the deb package get installed to, then do

```shell
dpkg --contents xxx.deb 
#或者
dpkg -L xxx.deb # 似乎要安装之后
```

---

## 直接解压

```shell
dpkg-deb -x $DEBFILE $TARGET_DIRECTORY
```

or if you don't have any debian tools at hand

```shell
ar p $DEBFILE data.tar.gz | tar -C $TARGET_DIRECTORY -xz
```

With more recent packages it might be `data.tar.xz` or something else though.
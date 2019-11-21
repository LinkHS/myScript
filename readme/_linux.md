# Common Commands

##  Find

### Exclude a specific folder

```shell
find . -path ./ggpay/model -prune -o -name '*.class'  -print 
```

### 只查找文件或文件夹

```shell
# 查找名为"work"的目录
find . -name work -type d

# 查找名为"work"的文件，不包含目录
find . -name work -not -type d
```



---
## Others

- `pgrep chrome`
- `killal chrome`
- `lastlog`: 查看users最近的登陆状态
- `shift+f`: 重新载入用`less` 查看的文件
- as

---
# 操作
## 定位文件位置

```shell
sudo updatedb #optional
locate xxx
```
---
## 编辑终端里的一行内容

- `ctrl+k`: 将光标后面的指令剪切掉
- `ctrl+u`: 将光标前面的内容剪切掉
- `ctrl+w`: 向前剪切一个单词
- `ctrl+y`: 粘贴剪切的内容
- `atl+.`: paste the last argument of previous command
- `ctrl+a`, `fn+left`: 光标跳转到行首
- `ctrl+e`, `fn+right`: 光标跳转到行尾
- `ctrl+left`, `alt+b`: 光标跳转到上一个单词前
- `ctrl+right`, `alt+f`: 光标跳转到下一个单词前
- `ctrl+x+e`: switch to default text editor. 这样可以编辑多行的单个命令如for循环 
- `fc`: modify previous command in the default text editor


- `alt+[0-9]`: 例如`alt+1`重复下一次操作一次（可能会显示`arg: 1`）。下一次的操作可以是"输入一个字母"、"`ctrl+left`光标跳转到上一个单词的操作"。

> 参见 [What is this “(arg: 1)” appearing in terminal/tty after I pressed a combination of keys?](https://askubuntu.com/questions/1045167/what-is-this-arg-1-appearing-in-terminal-tty-after-i-pressed-a-combination)

---
## Create a RAM disk

```shell
mkdir ~/RAM
sudo mount -t tmpfs tmpfs ~/RAM -o size=4096M
```

Append the following line into `/etc/fstab`.
`tmpfs	/home/austin/RAM tmpfs	nodev,nosuid,noexec,nodiratime,size=1024M	0 0`
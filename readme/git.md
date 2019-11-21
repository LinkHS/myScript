---
## 比较两个分支差异
show all commits that are in origin/master but not in master
`git log master..origin/master`

show all commits that are in master but not in origin/master
`git log origin/master..master`



## 解决文件权限改变

参考：[How to restore the permissions of files and directories within git if they have been modified?](https://stackoverflow.com/questions/2517339/how-to-restore-the-permissions-of-files-and-directories-within-git-if-they-have)

```shell
git diff -p -R --no-color \
    | grep -E "^(diff|(old|new) mode)" --color=never  \
    | git apply
```


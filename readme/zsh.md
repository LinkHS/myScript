安装了"fzf"等插件后，使用"ctrl + r"开启多历史命令菜单

---
在"zsh.rc"中添加函数或者别名，可以在terminal中使用fzfp进行预览
```
fzfp() {
fzf --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'}
```

```
alias fzfp='fzf --preview '"'"'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'"'"
```


---
## jupyter notebook 的27个小技巧
https://blog.csdn.net/u013084616/article/details/79126585

### 1. Keyboard Shortcuts
- `Cmd + Shift + P`/`Ctrl + Shift + P`  
  打开命令面板，然后就可以输入命令入"clear ..."

- `Esc + F`
  查找和替换你的代码，但不包括代码的输出内容

- `Esc + o`


### 

---
## Clear defined variables
- `%reset`
- `%reset -f`  
cleared all the variables and contents without prompt. `-f` does the force action on the given command without prompting for yes/no.



---
## nbdime
https://nbdime.readthedocs.io/en/stable/

```
nbdiff notebook_1.ipynb notebook_2.ipynb
```

---
## Strip output from Jupyter and IPython notebooks
https://github.com/kynan/nbstripout

Set up the git filter and attributes
```
nbstripout --install
```

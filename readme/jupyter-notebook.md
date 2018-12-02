

---
## matplotlib/opencv 显示
```
%matplotlib qt # for cv2.imshow()

%matplotlib inline # for pyplot.show()
```

---
## Install
```
pip install jupyter notebook
pip install autopep8

# 以下只需要在 base 中设置一次就好了
pip install jupyter_nbextensions_configurator jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

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

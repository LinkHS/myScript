## Install

```
pip install jupyter notebook

pip install jupyter_contrib_nbextensions
pip install jupytext
pip install nbdime
pip install autopep8
pip install jupyter_nbextensions_configurator jupyter_contrib_nbextensions

# 以下只需要在 base 中设置一次就好了
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

## Viewing all defined variables

打印出当前 jupyter 环境中所有的全局变量（不包含 import 的）
```
def printvars():
    tmp = globals().copy()
    print('all defined vars:', end=' ') 
    [print(k, end=', ') for k, v in tmp.items() if not str(type(v)).endswith('module\'>') 
                                                  and not k.startswith('_') 
                                                  and k != 'tmp' and k != 'In' and k != 'Out' 
                                                  and not hasattr(v, '__call__')]
```

只保留传进去的全局变量
```
def keep_global_var(var_list):
    tmp = globals().copy()
    v = [k for k, v in tmp.items() if not k.startswith('_') 
                                      and not str(type(v)).endswith('module\'>') 
                                      and k != 'tmp' and k != 'In' and k != 'Out' 
                                      and not hasattr(v, '__call__')]
    for _v in v:
        if _v not in var_list:
            del globals()[_v]
```

---
## autoreload
https://ipython.readthedocs.io/en/stable/config/extensions/autoreload.html

IPython extension to reload modules before executing user code.

autoreload reloads modules automatically before entering the execution of code typed at the IPython prompt.

`autoreload 0/1/2` 说明
- 0, Disable automatic reloading
- 1, Reload all modules imported with %aimport every time before executing the Python code typed.
- 2, Reload all modules (except those excluded by %aimport) every time before executing the Python code typed.


```
%reload_ext autoreload
%aimport myPackage # 这样修改 myPackage 的代码后就不需要重启 kernel 了
%autoreload 1
```

---
## Embedded Video 插入视频
代码框形式，需要运行后才显示
```
from IPython.display import HTML
HTML("""
html code
""")
```

markdown形式
```
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](https://youtu.be/siAMDK8C_x8)
```

---
## matplotlib/opencv 显示
```
%matplotlib qt # for cv2.imshow()

%matplotlib inline # for pyplot.show()
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

---
## Clear defined variables
- `%reset`
- `%reset -f`  
cleared all the variables and contents without prompt. `-f` does the force action on the given command without prompting for yes/no.

---
# 插件
## 创建配置文件

```shell
jupyter notebook --generate-config
```

---
## Jupytext
```shell
pip install jupytext
```

在" ~/.jupyter/jupyter_notebook_config.py" 添加:
```shell
c.NotebookApp.contents_manager_class="jupytext.TextFileContentsManager"
```

有了这个插件后可以直接在jupyter notebook中打开"py"、"md"文件运行

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

---
## Notedown
在" ~/.jupyter/jupyter_notebook_config.py" 添加:
```
c.NotebookApp.contents_manager_class = 'notedown.NotedownContentsManager'
```

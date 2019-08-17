#  Basic

## Managing environments

### 001 To Create or Remove Env

```
conda create -n env_name python=3

conda env remove -n env_name
```

### 002 To Enter or Leave environments

```
source activate env_name
source deactivate env_name
```

### 003 Saving and loading environments

```
conda env export > environment.yaml

# To create an environment from an environment file
conda env create -f environment.yaml
```

### 004 Listing environments

```
conda env list
```

### 005 List installed packages
```
conda list
```



## Manage Packages

### 001 Install common packages:

`conda install numpy pandas matplotlib`
`conda install jupyter notebook`
`conda install numpy=1.10`

### 002 Uninstall:

```
conda remove package_name
```

### 003 Update:

```
conda update package_name
conda upgrade conda
conda upgrade --all
```



## 添加镜像

```shell
conda config --prepend channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
```

```shell
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
```

###  001 直接通过镜像下载
```shell
conda install numpy -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
```

- [清华大学开源软件镜像站](https://mirror.tuna.tsinghua.edu.cn/help/anaconda/)

----

# Others

## Search

```shell
conda search *opencv*
conda search '*opencv*'
```

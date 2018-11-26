Managing environments
```
conda create -n env_name python=3

conda env remove -n env_name
```

To Enter or Leave environments
```
source activate env_name
source deactivate env_name
```

Saving and loading environments
```
conda env export > environment.yaml

# To create an environment from an environment file
conda env create -f environment.yaml
```

Listing environments
```
conda env list
```


List installed packages
`conda list`


Install packages:
`conda install numpy pandas matplotlib`
`conda install jupyter notebook`
`conda install numpy=1.10`


Uninstall:
```
conda remove package_name
```


Update:
```
conda update package_name
conda upgrade conda
conda upgrade --all
```


Search
```
conda search *opencv*
conda search '*opencv*'
```


---
配置

```
conda config --prepend channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/        
#conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
```

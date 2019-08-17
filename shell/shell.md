# Commands

## `date` 获取时间

```shell
DATE_WITH_TIME=`date "+%Y%m%d_%H%M%S"`
echo $DATE_WITH_TIME
>>>
20190224_124042
```

## `printf` 
`print` 不同于 `echo`， 可以输出 `\n`

```shell
printf 'line1\nline2' # zsh 环境下运行 shell script
>>>
line1
line2%
```

> The `printf` command doesn't start a new line after the output. The `%` character you see is from `zsh`. It indicates that the preceding line is potentially incomplete (because there was no terminating newline).
>
> To fix this, try `printf 'poo\n'` or `echo poo` (`echo` adds a newline by default).

## `read`

```shell
read -p "Enter Password" var
echo $var
```

---
# Script
## 同步输出 commands
```shell
# expands variables and prints a little + sign before the line.
set -x or set -o xtrace

# does not expand the variables before printing.
set -v or set -o verbose 

# turn off the above settings.
set +x or set +v 
```

---

# Example

## `while`  + `read` 

```shell
arrDomains=()
while read domain
do
    arrDomains+=($domain)
done

for line in ${arrDomains[@]}
do
echo $line
done
```



## CUDA

```shell
export CUDA_VISIBLE_DEVICES=0,3
echo $CUDA_VISIBLE_DEVICES
>>>
0,3
```


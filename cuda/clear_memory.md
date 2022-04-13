清理占用的显存

## 方法1
```python
import torch, gc
gc.collect()
torch.cuda.empty_cache()
```

## 方法2
> 参考：[stackoverflow](https://stackoverflow.com/questions/15197286/how-can-i-flush-gpu-memory-using-cuda-physical-reset-is-unavailable)

查看占用的进程：
```shell
sudo fuser -v /dev/nvidia*
```

输出示例：
```
                     USER        PID  ACCESS COMMAND
/dev/nvidia0:        root       1256  F...m  Xorg
                     username   2057  F...m  compiz
                     username   2759  F...m  chrome
                     username   2777  F...m  chrome
                     username   20450 F...m  python
                     username   20699 F...m  python
```

kill相关进程：
```shell
sudo kill -9 1256 2057 2759 2777 20450 20699
```
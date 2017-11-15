# Multi-GPU

```{.python .input  n=1}
from mxnet import gpu
ctx = gpu(0)
print("one gpu:", ctx)
ctx = [gpu(0), gpu(1), gpu(2), gpu(3)]
print("multi-gpu:", ctx)
```

```{.json .output n=1}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "one gpu: gpu(0)\nmulti-gpu: [gpu(0), gpu(1), gpu(2), gpu(3)]\n"
 }
]
```

# MultiBoxPrior
[x_left, y_up, x_right, y_down]

```{.python .input  n=2}
from mxnet import nd
from mxnet.contrib.ndarray import MultiBoxPrior
```

```{.python .input  n=3}
n = 2
# shape: batch x channel x height x weight
x = nd.ones(shape=(1, 1, n, n))

y1 = MultiBoxPrior(x, sizes=[1], ratios=[1])
print("y1", y1)

y2 = MultiBoxPrior(x, sizes=[1, .5], ratios=[1])
print("y2", y2)

#y = MultiBoxPrior(x, sizes=[1], ratios=[1, .5])
#print y

y3 = MultiBoxPrior(x, sizes=[.5], ratios=[1, 0.8])
print("y3", y3)

y = MultiBoxPrior(x, sizes=[.5], ratios=[.5])
print("y4", y)

#y = MultiBoxPrior(x, sizes=[1, .5], ratios=[1, .5])
#print y
```

```{.json .output n=3}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "y1 \n[[[-0.25 -0.25  0.75  0.75]\n  [ 0.25 -0.25  1.25  0.75]\n  [-0.25  0.25  0.75  1.25]\n  [ 0.25  0.25  1.25  1.25]]]\n<NDArray 1x4x4 @cpu(0)>\ny2 \n[[[-0.25 -0.25  0.75  0.75]\n  [ 0.    0.    0.5   0.5 ]\n  [ 0.25 -0.25  1.25  0.75]\n  [ 0.5   0.    1.    0.5 ]\n  [-0.25  0.25  0.75  1.25]\n  [ 0.    0.5   0.5   1.  ]\n  [ 0.25  0.25  1.25  1.25]\n  [ 0.5   0.5   1.    1.  ]]]\n<NDArray 1x8x4 @cpu(0)>\ny3 \n[[[ 0.          0.          0.5         0.5       ]\n  [ 0.0263932  -0.0295085   0.4736068   0.52950847]\n  [ 0.5         0.          1.          0.5       ]\n  [ 0.52639318 -0.0295085   0.97360682  0.52950847]\n  [ 0.          0.5         0.5         1.        ]\n  [ 0.0263932   0.4704915   0.4736068   1.02950847]\n  [ 0.5         0.5         1.          1.        ]\n  [ 0.52639318  0.4704915   0.97360682  1.02950847]]]\n<NDArray 1x8x4 @cpu(0)>\ny4 \n[[[ 0.   0.   0.5  0.5]\n  [ 0.5  0.   1.   0.5]\n  [ 0.   0.5  0.5  1. ]\n  [ 0.5  0.5  1.   1. ]]]\n<NDArray 1x4x4 @cpu(0)>\n"
 }
]
```

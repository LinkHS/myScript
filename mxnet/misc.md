# Multi-GPU

```{.python .input  n=1}
from mxnet import gpu
ctx = gpu(0)
print("one gpu:", ctx)
ctx = [gpu(0), gpu(1), gpu(2), gpu(3)]
print("multi-gpu:", ctx)
```

---
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

---
# Visualization module

```{.python .input}
import mxnet as mx
```

## Example1, FC

```{.python .input}
net = mx.sym.Variable('data')
net = mx.sym.FullyConnected(data=net, name='fc1', num_hidden=128)
mx.viz.plot_network(net, shape={'data':(100,100)})
```

## Example2, Conv

```{.python .input}
net = mx.sym.Variable('data')
net = mx.sym.Convolution(net, kernel=(3,3), stride=(1,1), num_filter=10)
mx.viz.plot_network(net, shape={'data':(10000,3,32,32)})
```

## Example3, Save to file

```{.python .input}
net = mx.sym.Variable('data')
net = mx.sym.Convolution(net, kernel=(3,3), stride=(1,1), num_filter=10)

digraph = mx.viz.plot_network(net, save_format = 'jpg') # jpg, png, pdf
digraph.render()
```

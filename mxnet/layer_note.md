# 获取某一层Feature Maps输入输出大小

只需要将这一层之后的层都注释掉

```{.python .input  n=1}
from mxnet import gluon
from mxnet import init
from mxnet import nd
from mxnet.gluon import nn
import sys
sys.path.append('..')
import utils
```

```{.python .input  n=2}
def mlpconv():
    out = nn.Sequential()
    out.add(
        nn.Conv2D(channels=20, kernel_size=5, strides=1, padding=2, activation='relu'),
        nn.MaxPool2D(pool_size=3, strides=2), 
        nn.Dropout(.5),
        nn.Conv2D(channels=10, kernel_size=3, strides=1, padding=1, activation='relu'),
        nn.AvgPool2D(pool_size=3),
        nn.Flatten()
    )
    return out
```

```{.python .input  n=3}
blk = mlpconv()
blk.initialize()

# Sample Number, Channel, Width, Height
x = nd.random.uniform(shape=(32, 1, 28, 28))
y = blk(x)
print("y.shape", y.shape)
```

```{.json .output n=3}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "y.shape (32, 160)\n"
 }
]
```

# 打印每一层信息

```{.python .input  n=4}
from mxnet import nd
from mxnet.gluon import nn
```

## Forward 之前的网络参数

```{.python .input  n=5}
class MyLayer(nn.Block):
    def __init__(self, **kwargs):
        super(MyLayer, self).__init__(**kwargs)
        with self.name_scope():
            self.dense0 = nn.Dense(64)
            self.dense1 = nn.Dense(120)
            
    def forward(self, x):
        print("MyLayer.forward, x input shape:", x.shape)
        x = nd.flatten(x)
        print("MyLayer.forward, x flatten shape:", x.shape)
        print("MyLayer.forward, start dense0.params:", self.dense0.params)
        x = nd.relu(self.dense0(x))
        print("MyLayer.forward, end dense0.params:", self.dense0.params)
        return nd.relu(self.dense1(x))
    
net = nn.Sequential()
with net.name_scope():
    net.add(nn.Conv2D(channels=64, kernel_size=3,padding=1, activation='relu'))
    net.add(nn.Flatten())
    net.add(nn.Dense(128))
    net.add(MyLayer())
```

```{.python .input  n=6}
print("net:", net)
print("type(net):", type(net))
print("net.name:", net.name)
print("net.prefix:", net.prefix)
print("net.firstLayer:", net[0])
print("net.firstLayer.name:", net[0].name)
print("net.Conv2D.params:", net[0].params)

print("\n----------\n")
myLayer = MyLayer()
print("myLayer:", myLayer)
print("myLayer.name:", myLayer.name)
print("myLayer.prefix:", myLayer.prefix)
print("myLayer.dense0.name:", myLayer.dense0.name)
print("myLayer.collect_params:", myLayer.collect_params())
```

```{.json .output n=6}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "net: Sequential(\n  (0): Conv2D(64, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1))\n  (1): Flatten\n  (2): Dense(128, linear)\n  (3): MyLayer(\n    (dense0): Dense(64, linear)\n    (dense1): Dense(120, linear)\n  )\n)\ntype(net): <class 'mxnet.gluon.nn.basic_layers.Sequential'>\nnet.name: sequential1\nnet.prefix: sequential1_\nnet.firstLayer: Conv2D(64, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1))\nnet.firstLayer.name: sequential1_conv0\nnet.Conv2D.params: sequential1_conv0_ (\n  Parameter sequential1_conv0_weight (shape=(64, 0, 3, 3), dtype=<class 'numpy.float32'>)\n  Parameter sequential1_conv0_bias (shape=(64,), dtype=<class 'numpy.float32'>)\n)\n\n----------\n\nmyLayer: MyLayer(\n  (dense0): Dense(64, linear)\n  (dense1): Dense(120, linear)\n)\nmyLayer.name: mylayer0\nmyLayer.prefix: mylayer0_\nmyLayer.dense0.name: mylayer0_dense0\nmyLayer.collect_params: mylayer0_ (\n  Parameter mylayer0_dense0_weight (shape=(64, 0), dtype=<class 'numpy.float32'>)\n  Parameter mylayer0_dense0_bias (shape=(64,), dtype=<class 'numpy.float32'>)\n  Parameter mylayer0_dense1_weight (shape=(120, 0), dtype=<class 'numpy.float32'>)\n  Parameter mylayer0_dense1_bias (shape=(120,), dtype=<class 'numpy.float32'>)\n)\n"
 }
]
```

## Forward 之后的网络参数和信息

```{.python .input  n=7}
net.initialize()
print("net.Conv2D.params:", net[0].params)
print("\n----------\n")
x = nd.random.uniform(shape=(4, 1, 8, 8)) # batch, channel, widht, height
y = net(x)

print("\n----------\n")
print("net.Conv2D.params:", net[0].params)
```

```{.json .output n=7}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "net.Conv2D.params: sequential1_conv0_ (\n  Parameter sequential1_conv0_weight (shape=(64, 0, 3, 3), dtype=<class 'numpy.float32'>)\n  Parameter sequential1_conv0_bias (shape=(64,), dtype=<class 'numpy.float32'>)\n)\n\n----------\n\nMyLayer.forward, x input shape: (4, 128)\nMyLayer.forward, x flatten shape: (4, 128)\nMyLayer.forward, start dense0.params: sequential1_mylayer0_dense0_ (\n  Parameter sequential1_mylayer0_dense0_weight (shape=(64, 0), dtype=<class 'numpy.float32'>)\n  Parameter sequential1_mylayer0_dense0_bias (shape=(64,), dtype=<class 'numpy.float32'>)\n)\nMyLayer.forward, end dense0.params: sequential1_mylayer0_dense0_ (\n  Parameter sequential1_mylayer0_dense0_weight (shape=(64, 128), dtype=<class 'numpy.float32'>)\n  Parameter sequential1_mylayer0_dense0_bias (shape=(64,), dtype=<class 'numpy.float32'>)\n)\n\n----------\n\nnet.Conv2D.params: sequential1_conv0_ (\n  Parameter sequential1_conv0_weight (shape=(64, 1, 3, 3), dtype=<class 'numpy.float32'>)\n  Parameter sequential1_conv0_bias (shape=(64,), dtype=<class 'numpy.float32'>)\n)\n"
 }
]
```

## 每层的 shape

```{.python .input  n=8}
class MyLayer(nn.Block):
    def __init__(self, verbose=False, **kwargs):
        super(MyLayer, self).__init__(**kwargs)
        self.verbose = verbose
        with self.name_scope():
            # block 1
            b1 = nn.Sequential()
            b1.add(
                nn.Conv2D(64, kernel_size=7, strides=2, padding=3, activation='relu'),
                nn.MaxPool2D(pool_size=3, strides=2)
            )
            # block 2
            b2 = nn.Sequential()
            b2.add(
                nn.Conv2D(64, kernel_size=1),
                nn.Conv2D(192, kernel_size=3, padding=1),
                nn.MaxPool2D(pool_size=3, strides=2)
            )
            # block 3
            b3 = nn.Sequential()
            b3.add(
                nn.Flatten(),
                nn.Dense(2)
            )
            # chain blocks together
            self.net = nn.Sequential()
            self.net.add(b1, b2, b3)
            
    def forward(self, x):
            out = x
            for i, b in enumerate(self.net):
                out = b(out)
                if self.verbose:
                    print('Block %d output: %s'%(i+1, out.shape))
            return out
```

```{.python .input  n=9}
net = MyLayer(verbose=True)
net.initialize()

x = nd.random.uniform(shape=(4, 3, 96, 96))
y = net(x)

print("\n----------\n")
print("Input shape:", x.shape)
print("Output shape:", y.shape)
```

```{.json .output n=9}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "Block 1 output: (4, 64, 23, 23)\nBlock 2 output: (4, 192, 11, 11)\nBlock 3 output: (4, 2)\n\n----------\n\nInput shape: (4, 3, 96, 96)\nOutput shape: (4, 2)\n"
 }
]
```

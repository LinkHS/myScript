# Iterators - Loading data
In this tutorial, we focus on how to feed data into a
training or inference program.
Most training and inference modules in MXNet
accept data iterators,
which simplifies this procedure, especially when reading
large datasets.
Here we discuss the API conventions and several provided
iterators.

## MXNet Data Iterator  
Data Iterators in *MXNet* are similar to Python iterator
objects.
In Python, the function `iter` allows fetching items sequentially by
calling  `next()` on
 iterable objects such as a Python `list`.
Iterators
provide an abstract interface for traversing various types of iterable
collections
 without needing to expose details about the underlying data source.
In MXNet, data iterators return a batch of data as `DataBatch` on each call to
`next`.
A `DataBatch` often contains *n* training examples and their
corresponding labels. Here *n* is the `batch_size` of the iterator. At the end
of the data stream when there is no more data to read, the iterator raises
``StopIteration`` exception like Python `iter`. 
The structure of `DataBatch` is
defined [here](http://mxnet.io/api/python/io.html#mxnet.io.DataBatch).
Information such as name, shape, type and layout on each training example and
their corresponding label can be provided as `DataDesc` data descriptor objects
via the `provide_data` and `provide_label` properties in `DataBatch`.
The
structure of `DataDesc` is defined
[here](http://mxnet.io/api/python/io.html#mxnet.io.DataDesc).

All IO in MXNet
is handled via `mx.io.DataIter` and its subclasses. In this tutorial, we'll
discuss a few commonly used iterators provided by MXNet.

Before diving into the
details let's setup the environment by importing some required packages:

```{.python .input  n=1}
import mxnet as mx
%matplotlib inline
import os
import subprocess
import numpy as np
import matplotlib.pyplot as plt
import tarfile

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)
```

## Reading data in memory
When data is stored in memory, backed by either an
`NDArray` or ``numpy`` `ndarray`,
we can use the
[__`NDArrayIter`__](http://mxnet.io/api/python/io.html#mxnet.io.NDArrayIter) to
read data as below:

```{.python .input  n=2}
import numpy as np
data = np.random.rand(100,3)
label = np.random.randint(0, 10, (100,))
data_iter = mx.io.NDArrayIter(data=data, label=label, batch_size=30)
for batch in data_iter:
    print([batch.data, batch.label, batch.pad])
```

```{.json .output n=2}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "[[\n[[ 0.36442053  0.09748361  0.47341979]\n [ 0.0516592   0.41586903  0.22330888]\n [ 0.26889923  0.6966154   0.61115515]\n [ 0.13914517  0.40640703  0.73347378]\n [ 0.57337934  0.78143132  0.04319736]\n [ 0.45883569  0.09894892  0.51457715]\n [ 0.58917177  0.13421755  0.8512705 ]\n [ 0.92653942  0.00127664  0.21745639]\n [ 0.80206496  0.53005534  0.80452222]\n [ 0.23276651  0.07846157  0.63086575]\n [ 0.82578659  0.6467346   0.79728413]\n [ 0.50670874  0.28348547  0.26646364]\n [ 0.540654    0.68742591  0.32935873]\n [ 0.64108062  0.37335747  0.35084441]\n [ 0.1624478   0.12021175  0.74660534]\n [ 0.64163244  0.42153761  0.96664661]\n [ 0.26580599  0.35914069  0.51573968]\n [ 0.36555427  0.44941223  0.17796755]\n [ 0.82381415  0.15935968  0.07910481]\n [ 0.22911389  0.52675635  0.66761887]\n [ 0.16544382  0.00436327  0.19773838]\n [ 0.0567846   0.32780865  0.92497909]\n [ 0.41809019  0.79195964  0.25254631]\n [ 0.067417    0.17996289  0.59454733]\n [ 0.42721745  0.02332321  0.23877059]\n [ 0.03882079  0.00720916  0.98950887]\n [ 0.7457341   0.23168628  0.42083451]\n [ 0.90524316  0.25913712  0.20491461]\n [ 0.43861002  0.53075069  0.24085923]\n [ 0.88384664  0.89385015  0.43060982]]\n<NDArray 30x3 @cpu(0)>], [\n[ 0.  1.  7.  4.  3.  8.  8.  0.  5.  1.  7.  5.  5.  0.  6.  6.  5.  7.\n  6.  2.  5.  1.  6.  1.  9.  7.  8.  1.  0.  1.]\n<NDArray 30 @cpu(0)>], 0]\n[[\n[[ 0.32001188  0.63120586  0.52946001]\n [ 0.83240598  0.93808973  0.40487975]\n [ 0.36347577  0.4916088   0.43538767]\n [ 0.62872076  0.82292432  0.85678923]\n [ 0.00347444  0.07932758  0.83079636]\n [ 0.8366996   0.6101259   0.97741652]\n [ 0.66550416  0.37315184  0.05079012]\n [ 0.87038714  0.66680872  0.87091833]\n [ 0.14703989  0.50037819  0.44533905]\n [ 0.93529588  0.79678291  0.997796  ]\n [ 0.71322954  0.43649399  0.02233594]\n [ 0.78779846  0.31841701  0.05308713]\n [ 0.87103081  0.98936671  0.97031027]\n [ 0.96606809  0.59082955  0.86816216]\n [ 0.87725931  0.66492951  0.30630288]\n [ 0.36067194  0.25746772  0.51867235]\n [ 0.74664629  0.33411056  0.84753734]\n [ 0.5377444   0.97822982  0.72888666]\n [ 0.21938165  0.31954908  0.79633015]\n [ 0.16346054  0.82626039  0.19760315]\n [ 0.64400846  0.51635844  0.99239212]\n [ 0.8928256   0.53245646  0.89720047]\n [ 0.78999418  0.80628598  0.19177495]\n [ 0.21901579  0.46068156  0.45632634]\n [ 0.60208285  0.00393023  0.84704947]\n [ 0.09849466  0.99895942  0.44604248]\n [ 0.09298733  0.14614254  0.58913308]\n [ 0.59858662  0.82785982  0.0466688 ]\n [ 0.57726473  0.19358967  0.34434748]\n [ 0.71452367  0.83960688  0.44859901]]\n<NDArray 30x3 @cpu(0)>], [\n[ 0.  6.  8.  1.  5.  6.  1.  3.  3.  1.  8.  1.  3.  2.  5.  1.  1.  5.\n  5.  3.  6.  7.  9.  2.  1.  2.  6.  5.  8.  9.]\n<NDArray 30 @cpu(0)>], 0]\n[[\n[[ 0.27525687  0.33574614  0.3817707 ]\n [ 0.99121791  0.3512758   0.89880157]\n [ 0.02466106  0.15867953  0.12615053]\n [ 0.28450215  0.60198647  0.90443748]\n [ 0.1079734   0.83961296  0.22433347]\n [ 0.25432774  0.98141158  0.67219156]\n [ 0.58274502  0.10474508  0.55344927]\n [ 0.14115727  0.50830257  0.38157618]\n [ 0.81258428  0.40522924  0.74587703]\n [ 0.8546375   0.32303911  0.63915426]\n [ 0.60443157  0.58790231  0.62212938]\n [ 0.10853638  0.92731363  0.47233826]\n [ 0.99239475  0.32333592  0.63274014]\n [ 0.88679194  0.66873664  0.14403774]\n [ 0.75059485  0.47896591  0.03411996]\n [ 0.38005078  0.87646824  0.25605822]\n [ 0.79242516  0.58636343  0.80138463]\n [ 0.25123444  0.4464297   0.88473767]\n [ 0.54946238  0.52451468  0.35430902]\n [ 0.10025936  0.81279057  0.84183699]\n [ 0.64947182  0.73172247  0.49562868]\n [ 0.32292539  0.54766405  0.27779919]\n [ 0.82980502  0.15488295  0.7004205 ]\n [ 0.86649585  0.7759313   0.66456419]\n [ 0.5696494   0.31631252  0.66239285]\n [ 0.82785392  0.6100952   0.223086  ]\n [ 0.90012819  0.48248237  0.46584785]\n [ 0.00837428  0.67561477  0.6912291 ]\n [ 0.84729123  0.92959142  0.56541562]\n [ 0.85188001  0.18011327  0.55029821]]\n<NDArray 30x3 @cpu(0)>], [\n[ 7.  2.  8.  1.  4.  0.  8.  1.  4.  7.  4.  4.  5.  2.  4.  4.  9.  5.\n  5.  6.  8.  1.  4.  9.  3.  9.  4.  2.  8.  8.]\n<NDArray 30 @cpu(0)>], 0]\n[[\n[[ 0.03692279  0.17310709  0.76501548]\n [ 0.12352844  0.10778441  0.52332318]\n [ 0.68025678  0.6777209   0.47191951]\n [ 0.44166973  0.26707634  0.62211484]\n [ 0.81718159  0.12356556  0.52306992]\n [ 0.3085036   0.43110916  0.42414749]\n [ 0.01407488  0.97611564  0.71674311]\n [ 0.58709008  0.27763042  0.13198462]\n [ 0.10697337  0.93353862  0.11974622]\n [ 0.91663575  0.09754344  0.009911  ]\n [ 0.36442053  0.09748361  0.47341979]\n [ 0.0516592   0.41586903  0.22330888]\n [ 0.26889923  0.6966154   0.61115515]\n [ 0.13914517  0.40640703  0.73347378]\n [ 0.57337934  0.78143132  0.04319736]\n [ 0.45883569  0.09894892  0.51457715]\n [ 0.58917177  0.13421755  0.8512705 ]\n [ 0.92653942  0.00127664  0.21745639]\n [ 0.80206496  0.53005534  0.80452222]\n [ 0.23276651  0.07846157  0.63086575]\n [ 0.82578659  0.6467346   0.79728413]\n [ 0.50670874  0.28348547  0.26646364]\n [ 0.540654    0.68742591  0.32935873]\n [ 0.64108062  0.37335747  0.35084441]\n [ 0.1624478   0.12021175  0.74660534]\n [ 0.64163244  0.42153761  0.96664661]\n [ 0.26580599  0.35914069  0.51573968]\n [ 0.36555427  0.44941223  0.17796755]\n [ 0.82381415  0.15935968  0.07910481]\n [ 0.22911389  0.52675635  0.66761887]]\n<NDArray 30x3 @cpu(0)>], [\n[ 7.  5.  4.  3.  9.  5.  4.  4.  5.  2.  0.  1.  7.  4.  3.  8.  8.  0.\n  5.  1.  7.  5.  5.  0.  6.  6.  5.  7.  6.  2.]\n<NDArray 30 @cpu(0)>], 20]\n"
 }
]
```

## Reading data from CSV files
MXNet provides
[`CSVIter`](http://mxnet.io/api/python/io.html#mxnet.io.CSVIter)
to read from
CSV files and can be used as below:

```{.python .input  n=3}
#lets save `data` into a csv file first and try reading it back
np.savetxt('data.csv', data, delimiter=',')
data_iter = mx.io.CSVIter(data_csv='data.csv', data_shape=(3,), batch_size=30)
for batch in data_iter:
    print([batch.data, batch.pad])
```

```{.json .output n=3}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "[[\n[[ 0.36442053  0.09748361  0.47341976]\n [ 0.0516592   0.415869    0.22330888]\n [ 0.26889923  0.69661534  0.61115515]\n [ 0.13914517  0.40640703  0.73347384]\n [ 0.57337934  0.78143132  0.04319736]\n [ 0.45883569  0.09894892  0.51457715]\n [ 0.58917177  0.13421755  0.8512705 ]\n [ 0.92653942  0.00127664  0.21745639]\n [ 0.80206501  0.53005534  0.80452222]\n [ 0.23276651  0.07846157  0.63086575]\n [ 0.82578659  0.6467346   0.79728413]\n [ 0.50670874  0.28348547  0.26646364]\n [ 0.540654    0.68742591  0.32935873]\n [ 0.64108062  0.37335747  0.35084441]\n [ 0.16244778  0.12021176  0.74660534]\n [ 0.64163244  0.42153758  0.96664667]\n [ 0.26580602  0.35914069  0.51573968]\n [ 0.36555427  0.44941226  0.17796755]\n [ 0.82381421  0.15935966  0.07910481]\n [ 0.22911389  0.52675641  0.66761887]\n [ 0.16544381  0.00436327  0.19773838]\n [ 0.0567846   0.32780868  0.92497903]\n [ 0.41809019  0.79195964  0.25254631]\n [ 0.067417    0.17996289  0.59454733]\n [ 0.42721742  0.02332321  0.23877057]\n [ 0.03882079  0.00720916  0.98950893]\n [ 0.7457341   0.23168628  0.42083448]\n [ 0.90524322  0.25913712  0.20491461]\n [ 0.43861002  0.53075063  0.24085923]\n [ 0.88384664  0.89385015  0.43060979]]\n<NDArray 30x3 @cpu(0)>], 0]\n[[\n[[ 0.32001191  0.63120586  0.52946001]\n [ 0.83240604  0.93808973  0.40487975]\n [ 0.36347574  0.4916088   0.43538767]\n [ 0.62872076  0.82292432  0.85678923]\n [ 0.00347444  0.07932758  0.83079636]\n [ 0.8366996   0.6101259   0.97741652]\n [ 0.66550416  0.37315184  0.05079012]\n [ 0.8703872   0.66680872  0.87091839]\n [ 0.14703989  0.50037819  0.44533905]\n [ 0.93529588  0.79678285  0.99779594]\n [ 0.71322954  0.43649396  0.02233594]\n [ 0.78779852  0.31841701  0.05308713]\n [ 0.87103081  0.98936671  0.97031021]\n [ 0.96606809  0.59082949  0.86816216]\n [ 0.87725925  0.66492951  0.30630288]\n [ 0.36067194  0.25746769  0.51867235]\n [ 0.74664629  0.33411056  0.84753734]\n [ 0.5377444   0.97822982  0.72888666]\n [ 0.21938165  0.31954908  0.79633015]\n [ 0.16346054  0.82626039  0.19760315]\n [ 0.64400846  0.51635844  0.99239218]\n [ 0.8928256   0.53245646  0.89720047]\n [ 0.78999412  0.80628598  0.19177493]\n [ 0.21901579  0.46068153  0.45632634]\n [ 0.60208285  0.00393023  0.84704953]\n [ 0.09849466  0.99895942  0.44604248]\n [ 0.09298733  0.14614253  0.58913308]\n [ 0.59858662  0.82785988  0.0466688 ]\n [ 0.57726467  0.19358969  0.34434748]\n [ 0.71452367  0.83960688  0.44859901]]\n<NDArray 30x3 @cpu(0)>], 0]\n[[\n[[ 0.27525687  0.33574614  0.3817707 ]\n [ 0.99121791  0.3512758   0.89880151]\n [ 0.02466106  0.15867953  0.12615053]\n [ 0.28450215  0.60198647  0.90443754]\n [ 0.1079734   0.83961296  0.22433348]\n [ 0.25432774  0.98141158  0.6721915 ]\n [ 0.58274502  0.10474508  0.55344927]\n [ 0.14115727  0.50830257  0.38157618]\n [ 0.81258428  0.40522924  0.74587703]\n [ 0.8546375   0.32303911  0.63915431]\n [ 0.60443157  0.58790231  0.62212938]\n [ 0.10853638  0.92731363  0.47233829]\n [ 0.99239475  0.32333592  0.63274014]\n [ 0.886792    0.66873658  0.14403775]\n [ 0.75059485  0.47896591  0.03411996]\n [ 0.38005078  0.8764683   0.25605822]\n [ 0.79242516  0.58636343  0.80138463]\n [ 0.25123444  0.44642967  0.88473767]\n [ 0.54946238  0.52451473  0.35430902]\n [ 0.10025936  0.81279057  0.84183693]\n [ 0.64947182  0.73172247  0.49562868]\n [ 0.32292539  0.54766405  0.27779919]\n [ 0.82980502  0.15488295  0.7004205 ]\n [ 0.86649579  0.77593124  0.66456419]\n [ 0.5696494   0.31631252  0.66239291]\n [ 0.82785398  0.6100952   0.223086  ]\n [ 0.90012819  0.48248237  0.46584788]\n [ 0.00837428  0.67561477  0.69122905]\n [ 0.84729117  0.92959148  0.56541556]\n [ 0.85187995  0.18011327  0.55029821]]\n<NDArray 30x3 @cpu(0)>], 0]\n[[\n[[ 0.03692279  0.1731071   0.76501548]\n [ 0.12352844  0.10778441  0.52332318]\n [ 0.68025678  0.6777209   0.47191954]\n [ 0.44166976  0.26707634  0.62211484]\n [ 0.81718159  0.12356557  0.52306998]\n [ 0.30850357  0.43110919  0.42414752]\n [ 0.01407488  0.97611558  0.71674311]\n [ 0.58709008  0.27763039  0.13198462]\n [ 0.10697337  0.93353862  0.11974622]\n [ 0.91663569  0.09754344  0.009911  ]\n [ 0.36442053  0.09748361  0.47341976]\n [ 0.0516592   0.415869    0.22330888]\n [ 0.26889923  0.69661534  0.61115515]\n [ 0.13914517  0.40640703  0.73347384]\n [ 0.57337934  0.78143132  0.04319736]\n [ 0.45883569  0.09894892  0.51457715]\n [ 0.58917177  0.13421755  0.8512705 ]\n [ 0.92653942  0.00127664  0.21745639]\n [ 0.80206501  0.53005534  0.80452222]\n [ 0.23276651  0.07846157  0.63086575]\n [ 0.82578659  0.6467346   0.79728413]\n [ 0.50670874  0.28348547  0.26646364]\n [ 0.540654    0.68742591  0.32935873]\n [ 0.64108062  0.37335747  0.35084441]\n [ 0.16244778  0.12021176  0.74660534]\n [ 0.64163244  0.42153758  0.96664667]\n [ 0.26580602  0.35914069  0.51573968]\n [ 0.36555427  0.44941226  0.17796755]\n [ 0.82381421  0.15935966  0.07910481]\n [ 0.22911389  0.52675641  0.66761887]]\n<NDArray 30x3 @cpu(0)>], 20]\n"
 }
]
```

## Custom Iterator
When the built-in iterators do not suit your application
needs,
you can create your own custom data iterator.

An iterator in _MXNet_
should
1. Implement `next()` in ``Python2`` or `__next()__` in ``Python3``,
returning a `DataBatch` or raising a `StopIteration` exception if at the end of
the data stream.
2. Implement the `reset()` method to restart reading from the
beginning.
3. Have a `provide_data` attribute, consisting of a list of
`DataDesc` objects that store the name, shape, type and layout information of
the data (more info
[here](http://mxnet.io/api/python/io.html#mxnet.io.DataBatch)).
4. Have a
`provide_label` attribute consisting of a list of `DataDesc` objects that store
the name, shape, type and layout information of the label.

When creating a new
iterator, you can either start from scratch and define an iterator or reuse one
of the existing iterators.
For example, in the image captioning application, the
input example is an image while the label is a sentence.
Thus we can create a
new iterator by:
- creating a `image_iter` by using `ImageRecordIter` which
provides multithreaded pre-fetch and augmentation.
- creating a `caption_iter`
by using `NDArrayIter` or the bucketing iterator provided in the *rnn* package.
- `next()` returns the combined result of `image_iter.next()` and
`caption_iter.next()`

The example below shows how to create a Simple iterator.

```{.python .input  n=4}
class SimpleIter(mx.io.DataIter):
    def __init__(self, data_names, data_shapes, data_gen,
                 label_names, label_shapes, label_gen, num_batches=10):
        self._provide_data = zip(data_names, data_shapes)
        self._provide_label = zip(label_names, label_shapes)
        self.num_batches = num_batches
        self.data_gen = data_gen
        self.label_gen = label_gen
        self.cur_batch = 0

    def __iter__(self):
        return self

    def reset(self):
        self.cur_batch = 0

    def __next__(self):
        return self.next()

    @property
    def provide_data(self):
        return self._provide_data

    @property
    def provide_label(self):
        return self._provide_label

    def next(self):
        if self.cur_batch < self.num_batches:
            self.cur_batch += 1
            data = [mx.nd.array(g(d[1])) for d,g in zip(self._provide_data, self.data_gen)]
            label = [mx.nd.array(g(d[1])) for d,g in zip(self._provide_label, self.label_gen)]
            return mx.io.DataBatch(data, label)
        else:
            raise StopIteration
```

We can use the above defined `SimpleIter` to train a simple MLP program below:

```{.python .input  n=5}
import mxnet as mx
num_classes = 10
net = mx.sym.Variable('data')
net = mx.sym.FullyConnected(data=net, name='fc1', num_hidden=64)
net = mx.sym.Activation(data=net, name='relu1', act_type="relu")
net = mx.sym.FullyConnected(data=net, name='fc2', num_hidden=num_classes)
net = mx.sym.SoftmaxOutput(data=net, name='softmax')
print(net.list_arguments())
print(net.list_outputs())
```

```{.json .output n=5}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "['data', 'fc1_weight', 'fc1_bias', 'fc2_weight', 'fc2_bias', 'softmax_label']\n['softmax_output']\n"
 }
]
```

Here, there are four variables that are learnable parameters:
the *weights* and
*biases* of FullyConnected layers *fc1* and *fc2*,
two variables for input data:
*data* for the training examples
and *softmax_label* contains the respective
labels and the *softmax_output*.

The *data* variables are called free variables
in MXNet's Symbol API.
To execute a Symbol, they need to be bound with data.
[Click here learn more about
Symbol](http://mxnet.io/tutorials/basic/symbol.html).

We use the data iterator
to feed examples to a neural network via MXNet's `module` API.
[Click here to
learn more about Module](http://mxnet.io/tutorials/basic/module.html).

```{.python .input  n=6}
import logging
logging.basicConfig(level=logging.INFO)

n = 32
data_iter = SimpleIter(['data'], [(n, 100)],
                  [lambda s: np.random.uniform(-1, 1, s)],
                  ['softmax_label'], [(n,)],
                  [lambda s: np.random.randint(0, num_classes, s)])

mod = mx.mod.Module(symbol=net)
mod.fit(data_iter, num_epoch=5)
```

```{.json .output n=6}
[
 {
  "ename": "ValueError",
  "evalue": "Data provided by data_shapes don't match names specified by data_names ([] vs. ['data'])",
  "output_type": "error",
  "traceback": [
   "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
   "\u001b[0;31mValueError\u001b[0m                                Traceback (most recent call last)",
   "\u001b[0;32m<ipython-input-6-a2ae3e4b88e5>\u001b[0m in \u001b[0;36m<module>\u001b[0;34m()\u001b[0m\n\u001b[1;32m      9\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m     10\u001b[0m \u001b[0mmod\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mmx\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mmod\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mModule\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0msymbol\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mnet\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m---> 11\u001b[0;31m \u001b[0mmod\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mfit\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mdata_iter\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mnum_epoch\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;36m5\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/module/base_module.py\u001b[0m in \u001b[0;36mfit\u001b[0;34m(self, train_data, eval_data, eval_metric, epoch_end_callback, batch_end_callback, kvstore, optimizer, optimizer_params, eval_end_callback, eval_batch_end_callback, initializer, arg_params, aux_params, allow_missing, force_rebind, force_init, begin_epoch, num_epoch, validation_metric, monitor)\u001b[0m\n\u001b[1;32m    485\u001b[0m                 \u001b[0;32mif\u001b[0m \u001b[0mmonitor\u001b[0m \u001b[0;32mis\u001b[0m \u001b[0;32mnot\u001b[0m \u001b[0;32mNone\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    486\u001b[0m                     \u001b[0mmonitor\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mtic\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 487\u001b[0;31m                 \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mforward_backward\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mdata_batch\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m    488\u001b[0m                 \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mupdate\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    489\u001b[0m                 \u001b[0;32mtry\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/module/base_module.py\u001b[0m in \u001b[0;36mforward_backward\u001b[0;34m(self, data_batch)\u001b[0m\n\u001b[1;32m    189\u001b[0m     \u001b[0;32mdef\u001b[0m \u001b[0mforward_backward\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mself\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mdata_batch\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    190\u001b[0m         \u001b[0;34m\"\"\"A convenient function that calls both ``forward`` and ``backward``.\"\"\"\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 191\u001b[0;31m         \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mforward\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mdata_batch\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mis_train\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;32mTrue\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m    192\u001b[0m         \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mbackward\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    193\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/module/module.py\u001b[0m in \u001b[0;36mforward\u001b[0;34m(self, data_batch, is_train)\u001b[0m\n\u001b[1;32m    592\u001b[0m                 \u001b[0mnew_lshape\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0;32mNone\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    593\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 594\u001b[0;31m             \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mreshape\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mnew_dshape\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mnew_lshape\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m    595\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    596\u001b[0m         \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0m_exec_group\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mforward\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mdata_batch\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mis_train\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/module/module.py\u001b[0m in \u001b[0;36mreshape\u001b[0;34m(self, data_shapes, label_shapes)\u001b[0m\n\u001b[1;32m    454\u001b[0m         \u001b[0;32massert\u001b[0m \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mbinded\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    455\u001b[0m         self._data_shapes, self._label_shapes = _parse_data_desc(\n\u001b[0;32m--> 456\u001b[0;31m             self.data_names, self.label_names, data_shapes, label_shapes)\n\u001b[0m\u001b[1;32m    457\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    458\u001b[0m         \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0m_exec_group\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mreshape\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0m_data_shapes\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0m_label_shapes\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/module/base_module.py\u001b[0m in \u001b[0;36m_parse_data_desc\u001b[0;34m(data_names, label_names, data_shapes, label_shapes)\u001b[0m\n\u001b[1;32m     69\u001b[0m     \u001b[0;34m\"\"\"parse data_attrs into DataDesc format and check that names match\"\"\"\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m     70\u001b[0m     \u001b[0mdata_shapes\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0;34m[\u001b[0m\u001b[0mx\u001b[0m \u001b[0;32mif\u001b[0m \u001b[0misinstance\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mx\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mDataDesc\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;32melse\u001b[0m \u001b[0mDataDesc\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m*\u001b[0m\u001b[0mx\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;32mfor\u001b[0m \u001b[0mx\u001b[0m \u001b[0;32min\u001b[0m \u001b[0mdata_shapes\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m---> 71\u001b[0;31m     \u001b[0m_check_names_match\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mdata_names\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mdata_shapes\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0;34m'data'\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0;32mTrue\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m     72\u001b[0m     \u001b[0;32mif\u001b[0m \u001b[0mlabel_shapes\u001b[0m \u001b[0;32mis\u001b[0m \u001b[0;32mnot\u001b[0m \u001b[0;32mNone\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m     73\u001b[0m         \u001b[0mlabel_shapes\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0;34m[\u001b[0m\u001b[0mx\u001b[0m \u001b[0;32mif\u001b[0m \u001b[0misinstance\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mx\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mDataDesc\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;32melse\u001b[0m \u001b[0mDataDesc\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m*\u001b[0m\u001b[0mx\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;32mfor\u001b[0m \u001b[0mx\u001b[0m \u001b[0;32min\u001b[0m \u001b[0mlabel_shapes\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/module/base_module.py\u001b[0m in \u001b[0;36m_check_names_match\u001b[0;34m(data_names, data_shapes, name, throw)\u001b[0m\n\u001b[1;32m     61\u001b[0m             name, name, str(data_shapes), str(data_names))\n\u001b[1;32m     62\u001b[0m         \u001b[0;32mif\u001b[0m \u001b[0mthrow\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m---> 63\u001b[0;31m             \u001b[0;32mraise\u001b[0m \u001b[0mValueError\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mmsg\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m     64\u001b[0m         \u001b[0;32melse\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m     65\u001b[0m             \u001b[0mwarnings\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mwarn\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mmsg\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;31mValueError\u001b[0m: Data provided by data_shapes don't match names specified by data_names ([] vs. ['data'])"
  ]
 }
]
```

## Record IO
Record IO is a file format used by MXNet for data IO.
It compactly
packs the data for efficient read and writes from distributed file system like
Hadoop HDFS and AWS S3.
You can learn more about the design of `RecordIO`
[here](http://mxnet.io/architecture/note_data_loading.html).

MXNet provides
[__`MXRecordIO`__](http://mxnet.io/api/python/io.html#mxnet.recordio.MXRecordIO)
and
[__`MXIndexedRecordIO`__](http://mxnet.io/api/python/io.html#mxnet.recordio.MXIndexedRecordIO)
for sequential access of data and random access of the data.

### MXRecordIO
First, let's look at an example on how to read and write sequentially
using
`MXRecordIO`. The files are named with a `.rec` extension.

```{.python .input  n=35}
record = mx.recordio.MXRecordIO('tmp.rec', 'w')
for i in range(5):
    record.write(('record_%d'%i).encode())
record.close()
```

We can read the data back by opening the file with an option `r` as below:

```{.python .input  n=29}
record = mx.recordio.MXRecordIO('tmp.rec', 'r')
while True:
    item = record.read()
    if not item:
        break
    print (item)
record.close()
```

```{.json .output n=29}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "b'record_0'\nb'record_1'\nb'record_2'\nb'record_3'\nb'record_4'\n"
 }
]
```

### MXIndexedRecordIO
`MXIndexedRecordIO` supports random or indexed access to
the data.
We will create an indexed record file and a corresponding index file
as below:

```{.python .input  n=32}
record = mx.recordio.MXIndexedRecordIO('tmp.idx', 'tmp.rec', 'w')
for i in range(5):
    record.write_idx(i, ('record_%d'%i).encode())
record.close()
```

Now, we can access the individual records using the keys

```{.python .input  n=33}
record = mx.recordio.MXIndexedRecordIO('tmp.idx', 'tmp.rec', 'r')
record.read_idx(3)
```

```{.json .output n=33}
[
 {
  "data": {
   "text/plain": "b'record_3'"
  },
  "execution_count": 33,
  "metadata": {},
  "output_type": "execute_result"
 }
]
```

You can also list all the keys in the file.

```{.python .input  n=34}
record.keys
```

```{.json .output n=34}
[
 {
  "data": {
   "text/plain": "[0, 1, 2, 3, 4]"
  },
  "execution_count": 34,
  "metadata": {},
  "output_type": "execute_result"
 }
]
```

### Packing and Unpacking data

Each record in a .rec file can contain arbitrary
binary data. However, most deep learning tasks require data to be input in
label/data format.
The `mx.recordio` package provides a few utility functions
for such operations, namely: `pack`, `unpack`, `pack_img`, and `unpack_img`.
#### Packing/Unpacking Binary Data
[__`pack`__](http://mxnet.io/api/python/io.html#mxnet.recordio.pack) and
[__`unpack`__](http://mxnet.io/api/python/io.html#mxnet.recordio.unpack) are
used for storing float (or 1d array of float) label and binary data. The data is
packed along with a header. The header structure is defined
[here](http://mxnet.io/api/python/io.html#mxnet.recordio.IRHeader).

```{.python .input  n=36}
# pack
data = 'data'
label1 = 1.0
header1 = mx.recordio.IRHeader(flag=0, label=label1, id=1, id2=0)
s1 = mx.recordio.pack(header1, data)

label2 = [1.0, 2.0, 3.0]
header2 = mx.recordio.IRHeader(flag=3, label=label2, id=2, id2=0)
s2 = mx.recordio.pack(header2, data)
```

```{.json .output n=36}
[
 {
  "ename": "TypeError",
  "evalue": "can't concat bytes to str",
  "output_type": "error",
  "traceback": [
   "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
   "\u001b[0;31mTypeError\u001b[0m                                 Traceback (most recent call last)",
   "\u001b[0;32m<ipython-input-36-c91751ef3dc5>\u001b[0m in \u001b[0;36m<module>\u001b[0;34m()\u001b[0m\n\u001b[1;32m      3\u001b[0m \u001b[0mlabel1\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0;36m1.0\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      4\u001b[0m \u001b[0mheader1\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mmx\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mrecordio\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mIRHeader\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mflag\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mlabel\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mlabel1\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mid\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;36m1\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mid2\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m----> 5\u001b[0;31m \u001b[0ms1\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mmx\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mrecordio\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mpack\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mheader1\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mdata\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m      6\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      7\u001b[0m \u001b[0mlabel2\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0;34m[\u001b[0m\u001b[0;36m1.0\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0;36m2.0\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0;36m3.0\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;32m~/VirtualEnv/mxnet_master/local/lib/python3.5/site-packages/mxnet/recordio.py\u001b[0m in \u001b[0;36mpack\u001b[0;34m(header, s)\u001b[0m\n\u001b[1;32m    339\u001b[0m         \u001b[0mheader\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mheader\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0m_replace\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mflag\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mlabel\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0msize\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mlabel\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    340\u001b[0m         \u001b[0ms\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mlabel\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mtostring\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;34m+\u001b[0m \u001b[0ms\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 341\u001b[0;31m     \u001b[0ms\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mstruct\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mpack\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0m_IR_FORMAT\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0;34m*\u001b[0m\u001b[0mheader\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;34m+\u001b[0m \u001b[0ms\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m    342\u001b[0m     \u001b[0;32mreturn\u001b[0m \u001b[0ms\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    343\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n",
   "\u001b[0;31mTypeError\u001b[0m: can't concat bytes to str"
  ]
 }
]
```

```{.python .input}
# unpack
print(mx.recordio.unpack(s1))
print(mx.recordio.unpack(s2))
```

#### Packing/Unpacking Image Data

MXNet provides
[__`pack_img`__](http://mxnet.io/api/python/io.html#mxnet.recordio.pack_img) and
[__`unpack_img`__](http://mxnet.io/api/python/io.html#mxnet.recordio.unpack_img)
to pack/unpack image data.
Records packed by `pack_img` can be loaded by
`mx.io.ImageRecordIter`.

```{.python .input}
data = np.ones((3,3,1), dtype=np.uint8)
label = 1.0
header = mx.recordio.IRHeader(flag=0, label=label, id=0, id2=0)
s = mx.recordio.pack_img(header, data, quality=100, img_fmt='.jpg')
```

```{.python .input}
# unpack_img
print(mx.recordio.unpack_img(s))
```

#### Using tools/im2rec.py
You can also convert raw images into *RecordIO*
format using the ``im2rec.py`` utility script that is provided in the MXNet
[src/tools](https://github.com/dmlc/mxnet/tree/master/tools) folder.
An example
of how to use the script for converting to *RecordIO* format is shown in the
`Image IO` section below.

## Image IO

In this section, we will learn how to
preprocess and load image data in MXNet.

There are 4 ways of loading image data
in MXNet.
   1. Using
[__mx.image.imdecode__](http://mxnet.io/api/python/io.html#mxnet.image.imdecode)
to load raw image files.
   2. Using
[__`mx.img.ImageIter`__](http://mxnet.io/api/python/io.html#mxnet.image.ImageIter)
implemented in Python which is very flexible to customization. It can read from
.rec(`RecordIO`) files and raw image files.
   3. Using
[__`mx.io.ImageRecordIter`__](http://mxnet.io/api/python/io.html#mxnet.io.ImageRecordIter)
implemented on the MXNet backend in C++. This is less flexible to customization
but provides various language bindings.
   4. Creating a Custom iterator
inheriting `mx.io.DataIter`


### Preprocessing Images
Images can be
preprocessed in different ways. We list some of them below:
- Using
`mx.io.ImageRecordIter` which is fast but not very flexible. It is great for
simple tasks like image recognition but won't work for more complex tasks like
detection and segmentation.
- Using `mx.recordio.unpack_img` (or `cv2.imread`,
`skimage`, etc) + `numpy` is flexible but slow due to Python Global Interpreter
Lock (GIL).
- Using MXNet provided `mx.image` package. It stores images in
[__`NDArray`__](http://mxnet.io/tutorials/basic/ndarray.html) format and
leverages MXNet's [dependency
engine](http://mxnet.io/architecture/note_engine.html) to automatically
parallelize processing and circumvent GIL.

Below, we demonstrate some of the
frequently used preprocessing routines provided by the `mx.image` package.
Let's download sample images that we can work with.

```{.python .input}
fname = mx.test_utils.download(url='http://data.mxnet.io/data/test_images.tar.gz', dirname='data', overwrite=False)
tar = tarfile.open(fname)
tar.extractall(path='./data')
tar.close()
```

#### Loading raw images
`mx.image.imdecode` lets us load the images. `imdecode`
provides a similar interface to ``OpenCV``.  

**Note:** You will still need
``OpenCV``(not the CV2 Python library) installed to use `mx.image.imdecode`.

```{.python .input}
img = mx.image.imdecode(open('data/test_images/ILSVRC2012_val_00000001.JPEG', 'rb').read())
plt.imshow(img.asnumpy()); plt.show()
```

#### Image Transformations

```{.python .input}
# resize to w x h
tmp = mx.image.imresize(img, 100, 70)
plt.imshow(tmp.asnumpy()); plt.show()
```

```{.python .input}
# crop a random w x h region from image
tmp, coord = mx.image.random_crop(img, (150, 200))
print(coord)
plt.imshow(tmp.asnumpy()); plt.show()
```

### Loading Data using Image Iterators

Before we see how to read data using the
two built-in Image iterators,
 lets get a sample __Caltech 101__ dataset
 that
contains 101 classes of objects and converts them into record io format.
Download and unzip

```{.python .input}
fname = mx.test_utils.download(url='http://www.vision.caltech.edu/Image_Datasets/Caltech101/101_ObjectCategories.tar.gz', dirname='data', overwrite=False)
tar = tarfile.open(fname)
tar.extractall(path='./data')
tar.close()
```

Let's take a look at the data. As you can see, under the root folder
(./data/101_ObjectCategories) every category has a
subfolder(./data/101_ObjectCategories/yin_yang).

Now let's convert them into
record io format using the `im2rec.py` utility script.
First, we need to make a
list that contains all the image files and their categories:

```{.python .input}
os.system('python %s/tools/im2rec.py --list=1 --recursive=1 --shuffle=1 --test-ratio=0.2 data/caltech data/101_ObjectCategories'%os.environ['MXNET_HOME'])
```

The resulting list file (./data/caltech_train.lst) is in the format `index\t(one
or more label)\tpath`. In this case, there is only one label for each image but
you can modify the list to add in more for multi-label training.

Then we can
use this list to create our record io file:

```{.python .input}
os.system("python %s/tools/im2rec.py --num-thread=4 --pass-through=1 data/caltech data/101_ObjectCategories"%os.environ['MXNET_HOME'])
```

The record io files are now saved at here (./data)

#### Using ImageRecordIter
[__`ImageRecordIter`__](http://mxnet.io/api/python/io.html#mxnet.io.ImageRecordIter)
can be used for loading image data saved in record io format. To use
ImageRecordIter, simply create an instance by loading your record file:

```{.python .input}
data_iter = mx.io.ImageRecordIter(
    path_imgrec="./data/caltech.rec", # the target record file
    data_shape=(3, 227, 227), # output data shape. An 227x227 region will be cropped from the original image.
    batch_size=4, # number of samples per batch
    resize=256 # resize the shorter edge to 256 before cropping
    # ... you can add more augumentation options as defined in ImageRecordIter.
    )
data_iter.reset()
batch = data_iter.next()
data = batch.data[0]
for i in range(4):
    plt.subplot(1,4,i+1)
    plt.imshow(data[i].asnumpy().astype(np.uint8).transpose((1,2,0)))
plt.show()
```

#### Using ImageIter
[__ImageIter__](http://mxnet.io/api/python/io.html#mxnet.io.ImageIter) is a
flexible interface that supports loading of images in both RecordIO and Raw
format.

```{.python .input}
data_iter = mx.image.ImageIter(batch_size=4, data_shape=(3, 227, 227),
                              path_imgrec="./data/caltech.rec",
                              path_imgidx="./data/caltech.idx" )
data_iter.reset()
batch = data_iter.next()
data = batch.data[0]
for i in range(4):
    plt.subplot(1,4,i+1)
    plt.imshow(data[i].asnumpy().astype(np.uint8).transpose((1,2,0)))
plt.show()
```

<!-- INSERT SOURCE DOWNLOAD BUTTONS -->

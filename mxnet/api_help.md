 # Table of Contents
<div class="toc" style="margin-top: 1em;"><ul class="toc-item" id="toc-level0"><li><span><a href="http://vmgpu011.hogpu.cc:8888/notebooks/mxnet/api_help.md#ndarray" data-toc-modified-id="ndarray-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>ndarray</a></span></li><li><span><a href="http://vmgpu011.hogpu.cc:8888/notebooks/mxnet/api_help.md#gluon" data-toc-modified-id="gluon-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>gluon</a></span><ul class="toc-item"><li><span><a href="http://vmgpu011.hogpu.cc:8888/notebooks/mxnet/api_help.md#gluon" data-toc-modified-id="gluon-2.1"><span class="toc-item-num">2.1&nbsp;&nbsp;</span>gluon</a></span></li><li><span><a href="http://vmgpu011.hogpu.cc:8888/notebooks/mxnet/api_help.md#gluon.nn" data-toc-modified-id="gluon.nn-2.2"><span class="toc-item-num">2.2&nbsp;&nbsp;</span>gluon.nn</a></span></li></ul></li></ul></div>

# ndarray

```{.python .input  n=1}
from mxnet import ndarray as nd
```

```{.python .input  n=2}
help(nd.pick)
```

```{.json .output n=2}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "Help on function pick:\n\npick(data=None, index=None, axis=_Null, keepdims=_Null, out=None, name=None, **kwargs)\n    Picks elements from an input array according to the input indices along the given axis.\n    \n    Given an input array of shape ``(d0, d1)`` and indices of shape ``(i0,)``, the result will be\n    an output array of shape ``(i0,)`` with::\n    \n      output[i] = input[i, indices[i]]\n    \n    By default, if any index mentioned is too large, it is replaced by the index that addresses\n    the last element along an axis (the `clip` mode).\n    \n    This function supports n-dimensional input and (n-1)-dimensional indices arrays.\n    \n    Examples::\n    \n      x = [[ 1.,  2.],\n           [ 3.,  4.],\n           [ 5.,  6.]]\n    \n      // picks elements with specified indices along axis 0\n      pick(x, y=[0,1], 0) = [ 1.,  4.]\n    \n      // picks elements with specified indices along axis 1\n      pick(x, y=[0,1,0], 1) = [ 1.,  4.,  5.]\n    \n      y = [[ 1.],\n           [ 0.],\n           [ 2.]]\n    \n      // picks elements with specified indices along axis 1 and dims are maintained\n      pick(x,y, 1, keepdims=True) = [[ 2.],\n                                     [ 3.],\n                                     [ 6.]]\n    \n    \n    \n    Defined in src/operator/tensor/broadcast_reduce_op_index.cc:L144\n    \n    Parameters\n    ----------\n    data : NDArray\n        The input array\n    index : NDArray\n        The index array\n    axis : int or None, optional, default='None'\n        The axis along which to perform the reduction. Negative values means indexing from right to left. ``Requires axis to be set as int, because global reduction is not supported yet.``\n    keepdims : boolean, optional, default=0\n        If this is set to `True`, the reduced axis is left in the result as dimension with size one.\n    \n    out : NDArray, optional\n        The output NDArray to hold the result.\n    \n    Returns\n    -------\n    out : NDArray or list of NDArrays\n        The output of this function.\n\n"
 }
]
```

```{.python .input  n=3}
help(nd.random_normal)
```

```{.json .output n=3}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "Help on function random_normal:\n\nrandom_normal(loc=_Null, scale=_Null, shape=_Null, ctx=_Null, dtype=_Null, out=None, name=None, **kwargs)\n    Draw random samples from a normal (Gaussian) distribution.\n    \n    .. note:: The existing alias ``normal`` is deprecated.\n    \n    Samples are distributed according to a normal distribution parametrized by *loc* (mean) and *scale* (standard deviation).\n    \n    Example::\n    \n       normal(loc=0, scale=1, shape=(2,2)) = [[ 1.89171135, -1.16881478],\n                                              [-1.23474145,  1.55807114]]\n    \n    \n    Defined in src/operator/random/sample_op.cc:L84\n    \n    Parameters\n    ----------\n    loc : float, optional, default=0\n        Mean of the distribution.\n    scale : float, optional, default=1\n        Standard deviation of the distribution.\n    shape : Shape(tuple), optional, default=()\n        Shape of the output.\n    ctx : string, optional, default=''\n        Context of output, in format [cpu|gpu|cpu_pinned](n). Only used for imperative calls.\n    dtype : {'None', 'float16', 'float32', 'float64'},optional, default='None'\n        DType of the output in case this can't be inferred. Defaults to float32 if not defined (dtype=None).\n    \n    out : NDArray, optional\n        The output NDArray to hold the result.\n    \n    Returns\n    -------\n    out : NDArray or list of NDArrays\n        The output of this function.\n\n"
 }
]
```

```{.python .input  n=4}
help(nd.take)
```

```{.json .output n=4}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "Help on function take:\n\ntake(a=None, indices=None, axis=_Null, mode=_Null, out=None, name=None, **kwargs)\n    Takes elements from an input array along the given axis.\n    \n    This function slices the input array along a particular axis with the provided indices.\n    \n    Given an input array with shape ``(d0, d1, d2)`` and indices with shape ``(i0, i1)``, the output\n    will have shape ``(i0, i1, d1, d2)``, computed by::\n    \n      output[i,j,:,:] = input[indices[i,j],:,:]\n    \n    .. note::\n       - `axis`- Only slicing along axis 0 is supported for now.\n       - `mode`- Only `clip` mode is supported for now.\n    \n    Examples::\n    \n      x = [[ 1.,  2.],\n           [ 3.,  4.],\n           [ 5.,  6.]]\n    \n      // takes elements with specified indices along axis 0\n      take(x, [[0,1],[1,2]]) = [[[ 1.,  2.],\n                                 [ 3.,  4.]],\n    \n                                [[ 3.,  4.],\n                                 [ 5.,  6.]]]\n    \n    \n    \n    Defined in src/operator/tensor/indexing_op.cc:L135\n    \n    Parameters\n    ----------\n    a : NDArray\n        The input array.\n    indices : NDArray\n        The indices of the values to be extracted.\n    axis : int, optional, default='0'\n        The axis of input array to be taken.\n    mode : {'clip', 'raise', 'wrap'},optional, default='clip'\n        Specify how out-of-bound indices bahave. \"clip\" means clip to the range. So, if all indices mentioned are too large, they are replaced by the index that addresses the last element along an axis.  \"wrap\" means to wrap around.  \"raise\" means to raise an error. \n    \n    out : NDArray, optional\n        The output NDArray to hold the result.\n    \n    Returns\n    -------\n    out : NDArray or list of NDArrays\n        The output of this function.\n\n"
 }
]
```

```{.python .input}
help(nd.Convolution)
```

```{.python .input}
help(nd.ROIPooling)
```

# gluon

```{.python .input}
from mxnet import gluon
```

## gluon

```{.python .input}
help(gluon.Trainer)
```

## gluon.nn

```{.python .input}
help(gluon.nn.Dense)
```

```{.python .input}
help(gluon.nn.Sequential)
```

```{.python .input}
help(gluon.nn.AvgPool2D)
```

```{.python .input}
help(gluon.nn.Conv2D)
```

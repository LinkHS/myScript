# HTML
## 01 图片

```html
<p align="center">
    <img src="imgs/seg_results1.png" width=600></br>
    <img src="imgs/seg_results2.png" width=600></br>
    <img src="imgs/seg_results3.png" width=600></br>
</p>
```

> `</br>` 代表换行



---
## 02 表格
- 定义表格，`<table border="1"> </table>` 
- 定义一行，`<tr> </tr>` 
- 单元格对齐方式（这里未起作用），`<tr align="right">` 和 `<tr align="center">` 
- 定义表头，`<th>Heading</th>` 
- 定义单元格，`<td>row 1, cell 1</td>` 

Example:
<table border="1">
<tr>
<th>Heading</th>
<th>Another Heading</th>
</tr>
<tr align='center'>
<td>row 1, cell 1</td>
<td>row 1, cell 2</td>
</tr>
<tr align="right">
<td>row 2, cell 1</td>
<td>row 2, cell 2</td>
</tr>
</table>


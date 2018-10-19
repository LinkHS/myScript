# Plugins
---
## vim-autopep8
使用`Autopep8`来reformat python code，也可以设置快捷键F8代替:Autopep8
```
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
```

---
## YouCompleteMe
```
Plugin 'Valloric/YouCompleteMe'
```

```
cd ~/.vim/bundle/YouCompleteMe
python3 install.py
```

---
## jedi-vim
因为和 YouCompleteMe 冲突，需要在 python 文件里禁用 ycm 功能
```
let g:ycm_filetype_blacklist = {'python': 1}
``` 


可用 "Ctrl+Space" 开启" 自动补全功能，以下是默认功能
```
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
```

## 快捷键
"ctrl+;": 显示历史复制命令
"cmd+w": 预览所有非最小化窗口
"cmd+tab": 从系统边栏选择应用
"alt+\`":

---
## 系统问题

### 解决双系统无法访问windows硬盘
1. 查看硬盘挂载情况
`sudo fdisk -l`

2. 修复相应分区
`sudo ntffix /dev/sda5`


---
## Others
### Terminal VPN
```
export http_proxy=http://<username>:<password>@10.191.131.3:3128
export https_proxy=http://<username>:<password>@10.191.131.3:3128
```

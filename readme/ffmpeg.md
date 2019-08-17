## 安装
```
sudo apt-get install ffmpeg
```

---
## 裁剪视频
```
# 从1秒开始持续15秒到16秒结束
ffmpeg -i ORIGINALFILE.mp4 -acodec copy -vcodec copy -ss 1 -t 00:15:00 OUTFILE-1.mp4

# 从0秒开始持续到最后
ffmpeg -i ORIGINALFILE.mp4 -acodec copy -vcodec copy -ss 0 OUTFILE-2.mp4
```

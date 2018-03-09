# 搜索安装过的opnecv程序

```{.python .input  n=4}
!dpkg -l | grep -i opencv
```

```{.json .output n=4}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "ii  libopencv-calib3d2.4v5:amd64                2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Camera Calibration library\r\nii  libopencv-contrib2.4v5:amd64                2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision contrib library\r\nii  libopencv-core2.4v5:amd64                   2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision core library\r\nii  libopencv-features2d2.4v5:amd64             2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Feature Detection and Descriptor Extraction library\r\nii  libopencv-flann2.4v5:amd64                  2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Clustering and Search in Multi-Dimensional spaces library\r\nii  libopencv-highgui2.4v5:amd64                2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision High-level GUI and Media I/O library\r\nii  libopencv-imgproc2.4v5:amd64                2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Image Processing library\r\nii  libopencv-legacy2.4v5:amd64                 2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision legacy library\r\nii  libopencv-ml2.4v5:amd64                     2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Machine Learning library\r\nii  libopencv-objdetect2.4v5:amd64              2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Object Detection library\r\nii  libopencv-video2.4v5:amd64                  2.4.9.1+dfsg-1.5ubuntu1                       amd64        computer vision Video analysis library\r\n"
 }
]
```

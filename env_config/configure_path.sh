MY_OPENCV3_INSTALL_PATH=/home/dawei.yang/3rdParty/opencv-3.2.0/build/install/lib
MY_OPENCV3_PYTHON_PATH=/home/dawei.yang/3rdParty/opencv-3.2.0/build/install/lib/python2.7/dist-packages

addTo_PATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) export PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

addTo_LD_LIBRARY_PATH() {
  case ":$LD_LIBRARY_PATH:" in
    *":$1:"*) :;; # already there
    *) export LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH";; # or PATH="$PATH:$1"
  esac
}

addTo_PYTHONPATH() {
  case ":$PYTHONPATH:" in
    *":$1:"*) :;; # already there
    *) export PYTHONPATH="$1:$PYTHONPATH";; # or PATH="$PATH:$1"
  esac
}

#export PYTHONPATH=${MY_OPENCV3_PYTHON_PATH}:${PYTHONPATH}
addTo_PYTHONPATH ${MY_OPENCV3_PYTHON_PATH}

#export LD_LIBRARY_PATH=${MY_OPENCV3_INSTALL_PATH}:${LD_LIBRARY_PATH}
addTo_LD_LIBRARY_PATH ${MY_OPENCV3_INSTALL_PATH}

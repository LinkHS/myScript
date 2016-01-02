#!/bin/bash

set -x
Project=$1
Lib=$2


rm -rf out/target/product/${Project}/obj_arm/SHARED_LIBRARIES/${Lib}*
rm out/target/product/${Project}/obj_arm/lib/${Lib}*.so
rm out/target/product/${Project}/obj/lib/${Lib}*.so
rm out/target/product/${Project}/system/lib/${Lib}*.so
rm out/target/product/${Project}/system/lib64/${Lib}*.so
rm -rf out/target/product/${Project}/obj/SHARED_LIBRARIES/${Lib}*

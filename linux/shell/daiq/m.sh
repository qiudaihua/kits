# !/bin/bash
set -x
export TARGET_HW_BOARD=cala02

source build/envsetup.sh

choosecomboext cala02 release msm8625 user

source build/link-proprietary.sh

#make clean
#make update-api

make -j4

set +x

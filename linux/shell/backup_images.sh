#!/bin/sh
set -

if [ -z $TARGET_PRODUCT ];then
    echo "!!!!No TARGET_PRODUCT selected, exit";
    exit 0;
else
    PLATFORM_VERSION0=`printconfig | grep PLATFORM_VERSION=`
    PLATFORM_VERSION0=${PLATFORM_VERSION0:17}
    echo "TARGET_PRODUCT is: $TARGET_PRODUCT";
    echo "PLATFORM_VERSION is: $PLATFORM_VERSION0";
    echo "TARGET_BUILD_VARIANT is: $TARGET_BUILD_VARIANT";
fi

BACK_PATH=/file/release/local_back/${TARGET_PRODUCT}-${PLATFORM_VERSION0}-${TARGET_BUILD_VARIANT}-`date +%Y-%m%d`
echo "BACK_PATH is: $BACK_PATH";
rm -rf $BACK_PATH
mkdir $BACK_PATH
mkdir $BACK_PATH/modem
mkdir $BACK_PATH/android

#there are many images, so only detect if the userdata_9.img, if exist ,cp all images to root/backup_images.
backup_metabuild(){
    pushd common/build/bin/asic/sparse_images
    if [ -e userdata_9.img ]; then
        cp  *.img $BACK_PATH/modem
        cp  *.xml   $BACK_PATH/modem
        cp  ../NON-HLOS.bin $BACK_PATH/modem
        cp  ../../../gpt_both0.bin $BACK_PATH/modem
        cp  ../../../gpt_main0.bin $BACK_PATH/modem
        cp  ../../../gpt_backup0.bin $BACK_PATH/modem
        cp ../../../patch0.xml $BACK_PATH/modem
    else
        echo "!!!!No userdata_9.img ,need metabuild!";
        #exit -1;
    fi
    popd
} 

backup_boot(){
    pushd boot_images/build/ms/bin/8x26
    if [ -e prog_emmc_firehose_8x26.mbn ]; then
        cp *.mbn $BACK_PATH/modem
        cp ../EMMCBLD/8926_msimage.mbn $BACK_PATH/modem
        cp ../EMMCBLD/8626_msimage.mbn $BACK_PATH/modem
    else
        echo "!!!!No boot images , pls check the boot_images build-log";
        #exit -1;
    fi
    popd
}
backup_trustzone(){
    pushd trustzone_images/build/ms/bin/FARAANBA
    if [ -e tz.mbn ]; then
        cp tz.mbn $BACK_PATH/modem
    else
        echo "!!!!No tz.mbn pls check the trustzone build-log";
        #exit -1;
    fi
    popd
}

backup_rpm(){
    pushd rpm_proc/build/ms/bin/AAAAANAAR
    if [ -e rpm.mbn ]; then
        cp rpm.mbn $BACK_PATH/modem
    else
        echo "!!!!No rpm.mbn exist, pls check the rpm build-log ";
        #exit -1;
    fi

    popd
}

backup_sdi(){
    pushd debug_image/build/ms/bin/AAAAANAZ
    if [ -e sdi.mbn ]; then
        cp sdi.mbn $BACK_PATH/modem
    else
        echo "!!!!No sdi.mbn pls check the debug build-log ";
        #exit -1;
    fi
    popd
}

backup_wncss(){
    pushd wcnss_proc/build/ms/bin/8x26
    if [ -e wcnss.mbn ]; then
        cp wcnss.mbn $BACK_PATH/modem
    else
        echo "!!!!No wcnss.mbn pls check the debug build-log ";
        #exit -1;
    fi
    popd
}

backup_adsp(){
    pushd adsp_proc/build/ms/bin/AAAAAAAA
    if [ -e dsp2.mbn ]; then
        cp dsp2.mbn $BACK_PATH/modem
    else
        echo "!!!!No dsp2.mbn pls check the debug build-log ";
        #exit -1;
    fi
    popd
}
backup_android(){
    pushd LINUX/android/out/target/product/${TARGET_PRODUCT}
    if [ -e system.img ]; then
        cp *.img $BACK_PATH/android
        cp emmc_appsboot.mbn $BACK_PATH/android
    else
        echo "!!!!No android images, pls check the android build-log ";
        #exit -1;
    fi
    popd
}

cd ../..
backup_metabuild
backup_boot
backup_trustzone
backup_rpm
backup_sdi
backup_wncss
backup_adsp
backup_android
cd LINUX/android/

set +

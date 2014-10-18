# !/bin/bash
#set -x
export PRODUCT_BUILD_VERSION=$1
export PRODUCT_BUILD_VERSION_INTERNAL=$2

HOST=192.168.180.182
RELEASE_ACOUNT=builder
RELEASE_PWD=gosobuilder123456

JOBS=$[2*`cat /proc/cpuinfo | grep processor | wc -l`]
KSRC=$PWD/kernel

MODELID=S399
MACHINEID=ualc05
BRAND=PHILIPS
#export MANUFACTURER=Haier
#export MANUFACTURER_CODE=Haier
TARGET_PRODUCT=S399
TARGET_BUILD_VARIANT=userdebug
TARGET_BUILD_TYPE=release
PRIVATE_SYSTEM_TAR=system.tar

TARGET_CHIPCODE=msm8226

export CCACHE_DIR=../.ccache
export USE_CCACHE=1

BUILDHOME=`pwd`
if [ ! -z $PRODUCT_BUILD_VERSION_INTERNAL ];then
    TARGET_HOME=$PWD/image/$BRAND/$MODELID/$PRODUCT_BUILD_VERSION_INTERNAL-`date +%Y-%m%d`
elif [ ! -z $PRODUCT_BUILD_VERSION ];then
    TARGET_HOME=$PWD/image/$BRAND/$MODELID/$PRODUCT_BUILD_VERSION-`date +%Y-%m%d`
else
    TARGET_HOME=$PWD/image/$BRAND/$MODELID/tmp-`date +%Y-%m%d`
fi
TARGET_DIR=$TARGET_HOME/image/android
TEST_REPORT_SW_DIR=$TARGET_HOME/test/sw_report
TEST_REPORT_HW_DIR=$TARGET_HOME/test/hw_report
LAST_TAGS=`cat "$TARGET_PRODUCT"_repo_last_tags`
REMOTE_TARGET_HOME=$RELEASE_ACOUNT@$HOST:/release/$TARGET_CHIPCODE/$BRAND/$MODELID
KMOD_PATH=$BUILDHOME/out/target/product/$TARGET_PRODUCT/system/lib/modules
LAST_OTA_PACKAGE_PATH=$REMOTE_TARGET_HOME/ota
OTA_PACKAGE_FILES=$BUILDHOME/out/target/product/$TARGET_PRODUCT/obj/PACKAGING/target_files_intermediates/$TARGET_PRODUCT-target_files-*.$LOGNAME.zip
VMLINUX=$BUILDHOME/out/target/product/$TARGET_PRODUCT/obj/KERNEL_OBJ/vmlinux

COPY_IMAGE_TO_SERVER="true"

NEED_TAG_RELEASE="false"
TAG_RELEASE_ANNOTATED="false"
if [[ ! -z $PRODUCT_BUILD_VERSION_INTERNAL ]] || [[ ! -z $PRODUCT_BUILD_VERSION ]];then
    NEED_TAG_RELEASE="true"
    echo -e "Important thing need your confirm"
    echo "Is it need to tag a new release.Input \"yes\" or \"y\" to confirm,otherwise skip tag a release?"
    read tag
    if [ "$tag" = "yes" -o "$tag" = "y" ] ; then
        TAG_RELEASE_ANNOTATED="true"
        echo "Please confirm last tag:\nInput \"yes\" or \"y\" to confirm,otherwise exit building"
        echo `cat "$TARGET_PRODUCT"_repo_last_tags`
        read last_tag_confirm
        if [ "$last_tag_confirm" = "yes" -o "$last_tag_confirm" = "y" ];then
            echo "use TAG:`cat "$TARGET_PRODUCT"_repo_last_tags` for commit-log generate. \n"
        else
            echo "last tag is not correct,exit build to change it please"
            exit 0
        fi
    fi
fi

if [ ! -d $CCACHE_DIR ];then
    prebuilts/misc/linux-x86/ccache/ccache -M 10G
fi

MP_BRANCH=`git branch | grep "*"`
MP_BRANCH=${MP_BRANCH:2}
echo "Please confirm MP branch.\nInput \"yes\" or \"y\" to confirm,otherwise exit building"
echo $MP_BRANCH
read mp_branch_confirm
if [ "$mp_branch_confirm" = "yes" -o "$mp_branch_confirm" = "y" ];then
    echo "MP branch: $MP_BRANCH to build.\n"
else
    echo "MP branch is not correct,exit build to change it please"
    exit 0
fi

AP_BRANCH=`ls -l .repo/manifest.xml`
AP_BRANCH=${AP_BRANCH##*"/"}
AP_BRANCH=${AP_BRANCH%%"."*}
echo "Please confirm AP branch.\nInput \"yes\" or \"y\" to confirm,otherwise exit building"
echo $AP_BRANCH
read ap_branch_confirm
if [ "$ap_branch_confirm" = "yes" -o "$ap_branch_confirm" = "y" ];then
    echo "AP branch: $AP_BRANCH to build.\n"
else
    echo "AP branch is not correct,exit build to change it please"
#    exit 0
fi

#git pull

#repo sync

pushd vendor/PHILIPS/S399
git fetch http://192.168.180.185:8081/goso-development/projects/PHILIPS/S399 refs/changes/49/5749/3 && git cherry-pick FETCH_HEAD
git fetch http://192.168.180.185:8081/goso-development/projects/PHILIPS/S399 refs/changes/50/5750/1 && git cherry-pick FETCH_HEAD
popd

pushd device/qcom/msm8226
git fetch http://192.168.180.185:8081/qct/platform/vendor/qcom/msm8226 refs/changes/53/5753/1 && git cherry-pick FETCH_HEAD
popd

source build/envsetup.sh
lunch `print_lunch_menu | grep $TARGET_PRODUCT-$TARGET_BUILD_VARIANT | cut -d. -f1`

#make clean
make installclean
make update-api -j $JOBS 2>&1 | tee update-api.log
rm -rf out/target/product/$TARGET_PRODUCT/installed-files.txt
#make showcommands -j $JOBS 2>&1 | tee mk.log
make -j $JOBS 2>&1 | tee andriod-build.log
if [ -f out/target/product/$TARGET_PRODUCT/installed-files.txt ]; then
    echo "android compile success!\n"
else
    echo "android compile fail!\n";
    exit 1;
fi

make otapackage -j $JOBS
#cd kernel
#find . -name "*.ko" >modules_list
#MODS=`cat modules_list` 
#for i in $MODS; do 
#cp $i $KMOD_PATH
#done
#cd -

if [ $COPY_IMAGE_TO_SERVER = "true" ]; then
    if [ -z $PRODUCT_BUILD_VERSION ]; then
        echo "wanring!!!!!!!no sw_version input, build code only, not release update files";
        exit 1;
    fi
    SW_VERSION=$PRODUCT_BUILD_VERSION
    CURRENT_TIME=`date +%Y%m%d%H%M`
    if [ $NEED_TAG_RELEASE = "true" ];then
        if [ ! -z $PRODUCT_BUILD_VERSION_INTERNAL ];then
            CURRENT_TAGS=$PRODUCT_BUILD_VERSION_INTERNAL
            SW_VERSION=$PRODUCT_BUILD_VERSION_INTERNAL
        else
            CURRENT_TAGS=$PRODUCT_BUILD_VERSION
            SW_VERSION=$PRODUCT_BUILD_VERSION
        fi
        LAST_TAGS=`cat "$TARGET_PRODUCT"_repo_last_tags`
        if [ $TAG_RELEASE_ANNOTATED = "true" ];then
            #repo forall -p -c "git tag -f -a $CURRENT_TAGS -m $CURRENT_TAGS"
            #repo forall -c "git remote | xargs git push --tags"
        else
            #repo forall -p -c "git tag -f $CURRENT_TAGS"
        fi

        if [ ! -z $LAST_TAGS ]; then
            #repo forall -p -c "git log $LAST_TAGS...$CURRENT_TAGS" >./$TARGET_PRODUCT-commit-log
            #echo "$CURRENT_TAGS" > "$TARGET_PRODUCT"_repo_last_tags
        fi
    fi

    if [ ! -d $TARGET_HOME ];then
        mkdir -p -m 777 $TARGET_DIR/unsigned-ota
        mkdir -p -m 777 $TEST_REPORT_SW_DIR
        mkdir -p -m 777 $TEST_REPORT_HW_DIR
    else
        rm -rf $TARGET_HOME
        mkdir -p -m 777 $TEST_REPORT_SW_DIR
        mkdir -p -m 777 $TARGET_DIR/unsigned-ota
    fi

    chmod 644 out/target/product/$TARGET_PRODUCT/userdata.img
    chmod 644 out/target/product/$TARGET_PRODUCT/system.img
    cp out/target/product/$TARGET_PRODUCT/userdata.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/system.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/cache.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/persist.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/misc.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/splash.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/boot.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/emmc_appsboot.mbn $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/system.tar.bz2 $TARGET_DIR/system-$MODELID-$CURRENT_TIME.tar.bz2
    cp out/target/product/$TARGET_PRODUCT/recovery.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/usbdisk.img $TARGET_DIR
    cp out/target/product/$TARGET_PRODUCT/*-ota-*.zip $TARGET_DIR/$MODELID-update-$SW_VERSION.zip
    cp $OTA_PACKAGE_FILES $TARGET_DIR/unsigned-ota
    cp $VMLINUX $TARGET_DIR
    cp $TARGET_PRODUCT-commit-log $TARGET_DIR/$TARGET_PRODUCT-$PRODUCT_BUILD_VERSION-commit-log
    sshpass -p $RELEASE_PWD scp -r $TARGET_HOME $REMOTE_TARGET_HOME

    rm -rf image
fi

generate_diff_ota_package(){
    mkdir ota
    scp $LAST_OTA_PACKAGE_PATH ota/
    cp $OTA_PACKAGE_FILES ota/
    a = ota/$LAST_OTA_PACKAGE_PATH
    b = ota/$OTA_PACKAGE_FILES
    ./build/tools/releasetools/ota_from_target_files -x pagesize=4096 -k ./build/target/product/security/testkey -d MMC  -v -i a b update-diff.zip
}

#set +x

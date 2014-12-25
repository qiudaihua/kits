#cp device/qcom/msm8226/init.target.rc $OUT/root/
#cp device/qcom/common/rootdir/etc/init.qcom.rc $OUT/root/
#cp device/qcom/msm8226/fstab.qcom $OUT/root/
PRODUCT_NAME=$(basename $OUT)
echo PRODUCT_NAME=$PRODUCT_NAME
function get_kernel_and_platform_name()
{
    check_file=$(basename $(ls  $OUT/obj/KERNEL_OBJ/arch/arm/boot/*.dtb))
    echo "retrieving... PLATFORM_NAME and KERNEL_NAME from $check_file"
    PLATFORM_NAME=`echo $check_file |grep -Eo '^[[:alnum:]]+-'|grep -Eo '^([[:alnum:]]+)'`
    echo PLATFORM_NAME=$PLATFORM_NAME
    KERNEL_NAME=`echo $check_file |grep -Eo '[[:alnum:]]+\.dtb'|grep -Eo '^([[:alnum:]]+)'`
    echo KERNEL_NAME=$KERNEL_NAME
}
function update_dts()
{
echo "updating dts..."
$OUT/obj/KERNEL_OBJ/scripts/dtc/dtc -p 1024 -O dtb -o $OUT/obj/KERNEL_OBJ/arch/arm/boot/$PLATFORM_NAME-goso-$KERNEL_NAME.dtb ./kernel/arch/arm/boot/dts/$PLATFORM_NAME-goso-$KERNEL_NAME.dts
cat $OUT/obj/KERNEL_OBJ/arch/arm/boot/zImage $OUT/obj/KERNEL_OBJ/arch/arm/boot/$PLATFORM_NAME-goso-$KERNEL_NAME.dtb > $OUT/obj/KERNEL_OBJ/arch/arm/boot/$PLATFORM_NAME-goso-$KERNEL_NAME-zImage
out/host/linux-x86/bin/acp -fp $OUT/obj/KERNEL_OBJ/arch/arm/boot/zImage $OUT/kernel
out/host/linux-x86/bin/dtbTool -o $OUT/dt.img -s 2048 -p $OUT/obj/KERNEL_OBJ/scripts/dtc/ $OUT/obj/KERNEL_OBJ/arch/arm/boot/
chmod a+r $OUT/dt.img
}
function update_kernel()
{
echo "updating kernel..."
mkdir -p $OUT/obj/KERNEL_OBJ/arch/arm/boot
#make -C kernel O=$OUT/obj/KERNEL_OBJ ARCH=arm CROSS_COMPILE=arm-eabi- ${KERNEL_NAME}_defconfig
#make -C kernel O=$OUT/obj/KERNEL_OBJ ARCH=arm CROSS_COMPILE=arm-eabi- headers_install
make -C kernel O=$OUT/obj/KERNEL_OBJ ARCH=arm CROSS_COMPILE=arm-eabi-
#make -C kernel O=$OUT/obj/KERNEL_OBJ ARCH=arm CROSS_COMPILE=arm-eabi- modules
#make -C kernel O=$OUT/obj/KERNEL_OBJ INSTALL_MOD_PATH=../../system INSTALL_MOD_STRIP=1 ARCH=arm CROSS_COMPILE=arm-eabi- modules_install
update_dts
}
function update_ramdisk()
{
echo "updating ramdisk..."
echo "#" > $OUT/root/default.prop; \
         echo "# ADDITIONAL_DEFAULT_PROPERTIES" >> $OUT/root/default.prop; \
         echo "#" >> $OUT/root/default.prop;
echo "ro.secure=0" >> $OUT/root/default.prop
echo "ro.allow.mock.location=0" >> $OUT/root/default.prop;
echo "ro.debuggable=1" >> $OUT/root/default.prop
echo "persist.sys.strict_op_enable=false" >> $OUT/root/default.prop; 
echo "persist.sys.whitelist=/system/etc/whitelist_appops.xml" >> $OUT/root/default.prop
echo "persist.sys.usb.config=adb" >> $OUT/root/default.prop
build/tools/post_process_props.py $OUT/root/default.prop

out/host/linux-x86/bin/mkbootfs $OUT/root | out/host/linux-x86/bin/minigzip > $OUT/ramdisk.img
rm $OUT/root/default.prop
}
function make_boot()
{
#out/host/linux-x86/bin/mkbootimg  --kernel $OUT/kernel --ramdisk $OUT/ramdisk.img --cmdline "androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37" --base 0x00000000 --pagesize 2048  --dt $OUT/dt.img  --output $OUT/boot.img

out/host/linux-x86/bin/mkbootimg  --kernel $OUT/kernel --ramdisk $OUT/ramdisk.img --cmdline "androidboot.hardware=qcom androidboot.oem.product=$PRODUCT_NAME user_debug=31 msm_rtb.filter=0x37" --base 0x00000000 --pagesize 2048  --dt $OUT/dt.img  --output $OUT/boot.img
echo "new boot.img generated"
}
function update()
{
    if [[ "dts" =~ ^$1 ]] ;then
        update_dts
    elif [[ "ramdisk" =~ ^$1 ]];then
        update_ramdisk
    elif [[ "kernel" =~ ^$1 ]];then
        update_kernel
    elif [[ "flash" =~ ^$1 ]];then
        echo "flash new boot.img to connected phone..."
        adb reboot bootloader
        sleep 2
        fastboot flash boot $OUT/boot.img
        fastboot reboot
        return
    else 
        echo "invalid argument $1"
        return 
    fi
    make_boot
}
get_kernel_and_platform_name
while [ $# -ge 1 ] 
do
update $1
shift
done

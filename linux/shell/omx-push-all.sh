#!/bin/sh
#mmm -B vendor/qcom/proprietary/mm-video/
adb push  out/target/product/msm8625/system/lib/libmm-adspsvc.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libdivxdrmdecrypt.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxH264Dec.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxMpeg4Dec.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxWmvDec.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxOn2Dec.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxrv9Dec.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxVp8Dec.so /system/lib/
adb push  out/target/product/msm8625/system/bin/mm-vdec-omx-test /system/bin/
adb push  out/target/product/msm8625/system/lib/liblasic.so /system/lib/
adb push  out/target/product/msm8625/system/bin/ast-mm-vdec-omx-test7k /system/bin/
adb push  out/target/product/msm8625/system/lib/libOmxVidEnc.so /system/lib/
adb push  out/target/product/msm8625/system/bin/mm-venc-omx-test /system/bin/
adb push  out/target/product/msm8625/system/lib/libOmxIttiamVdec.so /system/lib/
adb push  out/target/product/msm8625/system/lib/libOmxIttiamVenc.so /system/lib/
adb push  out/target/product/msm8625/system/bin/mm-adspsvc-test /system/bin/


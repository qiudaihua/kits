#!/bin/bash

framework_jars="android.jar core.jar conscrypt.jar okhttp.jar core-junit.jar bouncycastle.jar ext.jar framework.jar framework2.jar telephony-common.jar voip-common.jar mms-common.jar android.policy.jar services.jar apache-xml.jar webviewchromium.jar telephony-msim.jar"

#rm -rf framework
rm -rf framework/android
mkdir -p framework/android

cp ${framework_jars} framework
ls framework

cd framework/android
for one_jar in ${framework_jars}
do
    jar xvf ../"${one_jar}"
done

rm -rf META-INF
jar cvf android.jar *
ls
cd -

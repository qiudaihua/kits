#!/bin/bash

keytool -genkey -alias android -keypass xunyang.cn -keyalg RSA -keysize 2048 -validity 10000 -keystore android.keystore -storepass xunyang.keystore -dname "CN=app, OU=sw16, O=xunyang, L=sz, ST=GD, C=CN"

 keytool -list  -v -keystore android.keystore -storepass xunyang.keystore


echo 设置Windows环境

::添加环境变量JAVA_HOME
@echo off
echo 添加java环境变量
set regpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set evname=JAVA_HOME
set javapath=E:\windows\work\tool\java\jdk1.8.0_25
reg add "%regpath%" /v %evname% /d %javapath% /f
pause>nul


::setx XERCES_HOME=%MY_JAVA%\Xerces2-J-2.6.2
::setx PATH=%PATH%;%XERCES_HOME%\binecho
::setx ANT_HOME=%MY_JAVA%\ant-1.6
::setx PATH=%PATH%;%ANT_HOME%\binecho
::setx MAVEN_HOME=%MY_JAVA%\maven-1.0.2
::setx MAVEN_REPO=%MY_JAVA%\repository
::setx PATH=%PATH%;%MAVEN_HOME%\binecho
::setx JBOSS_HOME=%MY_JAVA%\jboss-4.0.2
::setx PATH=%PATH%;%JBOSS_HOME%\binecho
::setx TOMCAT_HOME=%MY_JAVA%\jakarta-tomcat-5.5.9
::setx PATH=%PATH%;%TOMCAT_HOME%\binecho
::setx ECLISPE_HOME=%MY_JAVA%\eclipse
::setx PATH=%PATH%;%ECLISPE_HOME%\bin

::echo 设置 CAVAJ 环境变量
::setx CAVAJ_HOME=%MY_JAVA%\cavaj-1.11
::setx PATH=%PATH%;%CAVAJ_HOME%echo
::setx CVSROOT=%MY_JAVA%\cvsrepository
C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Intel\Intel(R) Management Engine Components\DAL;C:\Program Files (x86)\Intel\Intel(R) Management Engine Components\DAL;C:\Program Files\Intel\Intel(R) Management Engine Components\IPT;C:\Program Files (x86)\Intel\Intel(R) Management Engine Components\IPT;C:\Program Files (x86)\QuickTime\QTSystem\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;E:\windows\work\tool\Git\cmd
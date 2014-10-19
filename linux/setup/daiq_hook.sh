#work kits hook shell
DAIQ_WORK_HOME=/work
DAIQ_JDK_VER=1.7*
if [ -d "${DAIQ_WORK_HOME}/kits/linux/setup" ] ; then
    . ${DAIQ_WORK_HOME}/kits/linux/setup/hook.sh
fi

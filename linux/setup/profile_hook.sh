#work kits hook shell
export DAIQ_WORK_HOME=/work
DAIQ_JDK_VER=1.7*
if [ -f "${DAIQ_WORK_HOME}/kits/linux/setup/profile.sh" ] ; then
    . ${DAIQ_WORK_HOME}/kits/linux/setup/profile.sh
fi

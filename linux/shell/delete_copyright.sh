#/bin/bash

FILE_LIST=`find src/ res/**/*.xml -name "*.*"`
#FILE_LIST=`find src/**/*.java -name "*.*"`
#FILE_LIST=`find res/**/*.xml -name "*.*"`
#FILE_LIST=`find res/values-land/config.xml -name "*.*"`

#find src/ res/ -name "*.*" -exec grep -n "Copyright" {} \; | cut -d ":" -f 1 | head -n 1

for TARGET in ${FILE_LIST}
do
    LN_H=`grep -n "Copyright" "${TARGET}" | cut -d ":" -f 1 | head -n 1 `
    LN_T=`grep -n "limitations under the License." "${TARGET}" | cut -d ":" -f 1 | head -n 1 `
    LN_SRC_H=`grep -n "\/\*" "${TARGET}" | cut -d ":" -f 1 | head -n 1 `
    LN_SRC_T=`grep -n "\*/" "${TARGET}" | cut -d ":" -f 1 | head -n 1 `
    LN_XML_H=`grep -n "\!\-\-" "${TARGET}" | cut -d ":" -f 1 | head -n 1 `
    LN_XML_T=`grep -n "\-\-" "${TARGET}" | cut -d ":" -f 1 | head -n 2 | tail -n 1 `
    #echo LN_SRC_H=${LN_SRC_H}
    #echo LN_SRC_T=${LN_SRC_T}
    #echo LN_XML_H=${LN_XML_H}
    #echo LN_XML_T=${LN_XML_T}
    if [ -z "${LN_H}" ]; then
        continue;
    fi
    echo TARGET=${TARGET}
    if [ ! -z "${LN_SRC_H}" ]; then
        if [ ${LN_H} -gt ${LN_SRC_H} ]; then
            LN_H=${LN_SRC_H}
        fi
        if [ ! -z ${LN_H} ]; then
            LN_H=${LN_SRC_H}
            if [ ${LN_T} -lt ${LN_SRC_T} ]; then
                LN_T=${LN_SRC_T}
            fi
        fi
    elif [ ! -z "${LN_XML_H}" ]; then
        if [ ${LN_H} -gt ${LN_XML_H} ]; then
            LN_H=${LN_XML_H}
        fi
        if [ ! -z ${LN_XML_T} ]; then
            if [ ${LN_T} -lt ${LN_XML_T} ]; then
                LN_T=${LN_XML_T}
            fi
        fi
    fi

    echo LN_H=${LN_H}
    echo LN_T=${LN_T}
    if [ ! -z "${LN_T}" ]; then
        sed -i "${LN_H},${LN_T}d" ${TARGET}
    fi
done
 

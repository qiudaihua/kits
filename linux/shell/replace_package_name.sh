#/bin/bash

if [ ! -z $2 ]; then
  ORIGIN_PACKAGE=$1
  REPLACE_PACKAGE=$2

  ORIGIN_FOLDER="src/${ORIGIN_PACKAGE//\./\/}"
  REPLACE_FOLDER="src/${ORIGIN_PACKAGE//\./\/}"

  mkdir -p ${REPLACE_FOLDER}
  rm -rf ${REPLACE_FOLDER}
  mv -f ${ORIGIN_FOLDER} ${REPLACE_FOLDER}

  find ./* -name "*.*" -exec sed -i s/"${ORIGIN_PACKAGE}"/"${REPLACE_PACKAGE}"/g {} \;
else
  echo "REPLACE_PACKAGE is null!!"
fi

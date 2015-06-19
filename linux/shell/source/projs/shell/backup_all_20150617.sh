#!/bin/bash

backup_dir=$1


#7z a -t7z  -v1g ${backup_dir}/goso.7z goso/
#7z a -t7z  -v1g ${backup_dir}/modem.7z modem/
#7z a -t7z  -v1g ${backup_dir}/gaep.7z gaep/
#7z a -t7z  -v1g ${backup_dir}/qrd.7z qrd/
7z a -t7z  -v1g ${backup_dir}/qct.7z qct/
#7z a -t7z  -v1g ${backup_dir}/android-org.7z android-org/
#7z a -t7z  -v1g ${backup_dir}/cymod.7z cymod/



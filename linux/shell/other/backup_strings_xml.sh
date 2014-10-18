#!/bin/bash
#
# short-Description: backup all LANGUAGE_DIR/string.xml in SEARCH_DIR to OUT_DIR.
# Usage: ./backup_strings_xml.sh [-d language_dir] [dirname...]
#        -d      - specify language dircectory name,such as: -d values-fr
#                  for French.
#        dirname - directory not in SEARCH_DIR but need to backup

LANGUAGE_DIR="values"
if (($# >= 2))
then 
    if (($1 == "-d"))
    then 
        LANGUAGE_DIR=$2
        shift 2 # remove -d language_dir
    fi
fi

echo ""
echo Search: $LANGUAGE_DIR/string.xml

SEARCH_DIR="frameworks \
			device \
			external/chromium_org \
			packages \
			vendor/qcom \
		   "
SEARCH_DIR="$SEARCH_DIR $*"
echo Directory:$SEARCH_DIR

CURRENT_TIME=`date +%Y%m%d%H%M`
OUT_DIR="STR-XML"-$CURRENT_TIME
echo Output Directory:$OUT_DIR
echo ""

declare -i COUNT=0

function strings_file_Copy {
	local cnt;
	while true
	do
		read dir

		if [ -z $dir ]
		then
			break;
		fi

		strfile="$dir/strings.xml"
		outdir="$OUT_DIR/$dir"
		if [ -e $strfile ]
		then
			mkdir -p $outdir
			cp $strfile $outdir
			(( cnt+=1 ))
			echo -en "$cnt\t"
			ls $strfile
		fi
	done

	return $cnt
}

for dir in $SEARCH_DIR
do
	if [ -d $dir ]
	then
		find $dir -type d -name $LANGUAGE_DIR | grep -v tests | strings_file_Copy
		(( COUNT+=$? ))
		echo ""
	fi
done

echo "backup success"
echo "Total $COUNT files backup to $OUT_DIR"
echo ""

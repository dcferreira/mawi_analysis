#!/bin/sh
OPTION=$1
YEAR=$2
MONTH=$3
NR=$4
FILENAME="${YEAR}-${MONTH}_${NR}"

if [ $OPTION == "download" ]; then
    if [ ! -f "/shared/downloads/${FILENAME}.gz" ]; then
        wget $(python generate_url.py $YEAR $MONTH $NR) -O ${FILENAME}.gz
        mv ${FILENAME}.gz /shared/downloads/${FILENAME}.gz
    fi
else
    gunzip -c /shared/downloads/${FILENAME}.gz > ${FILENAME}
    # correct duplicate packets in 2015
    if [ "$YEAR" -eq 2015 ]; then
        editcap -D64 $FILENAME "${FILENAME}_fixed"
        mv ${FILENAME}_fixed $FILENAME
    fi
    go-flows run -sort start features /shared/features.json export csv /shared/out/${FILENAME}.csv source libpcap ${FILENAME}
fi

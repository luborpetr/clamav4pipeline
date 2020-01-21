#!/bin/bash

MAX_RETRIES=5
DATA_DIR="/clamavdb"

function updatedb() {
	/usr/bin/freshclam --datadir=$DATA_DIR --config-file=/etc/clamav/freshclam.conf
}

function check-db-integrity() {
 if [[ -f $DATA_DIR/bytecode.cvd && -f $DATA_DIR/daily.cvd && -f $DATA_DIR/main.cvd ]];then
    echo "AV DB integrity check is fine"
    return 0
 fi
 echo "AV DB integrity check has failed, some files are missing."
 return 1
}

for (( i=1; i<MAX_RETRIES; i++ ));
do 
 echo "DB Update attempt no.: $i"
 updatedb
 EXIT_CODE=$?
 check-db-integrity
 INTEGRITY_CHECK=$?
 if [[ $EXIT_CODE -eq 0 && $INTEGRITY_CHECK -eq 0 ]]; then 
  echo  "DB updated succesfully"
  exit 0
 fi
 sleep 60
done ;

echo "DB update failed"
exit 1

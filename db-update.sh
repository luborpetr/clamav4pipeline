#!/bin/bash

MAX_RETRIES=5

function updatedb() {
	/usr/bin/freshclam --datadir="/clamavdb" --config-file=/etc/clamav/freshclam.conf
}

for (( i=1; i<MAX_RETRIES; i++ ));
do 
 echo "DB Update attempt no.: $i"
 updatedb
 EXIT_CODE=$?
 if [ $EXIT_CODE -eq 0 ]; then 
  echo  "DB updated succesfully"
  exit 0
 fi
 sleep 60
done ;

echo "DB update failed"
exit 1

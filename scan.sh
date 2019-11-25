#!/bin/bash

function help() {
 echo "Command usage: scan.sh [OPTIONS]"
 echo "Mandatory arguments:"
 echo "-d Directory to be scanned"
 echo "-l Output log file path"
 echo
}

while getopts ":hd:l:" opt; do
  case ${opt} in
    d )
      SCAN_DIR=$OPTARG
      ;;
    l )
      LOG_FILE=$OPTARG
      ;;
    h )
      help
      exit 1
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done

if [ -n "${SCAN_DIR}" ] && [ -n "${LOG_FILE}" ] ; 
then
	echo "Scanning directory $SCAN_DIR"
	if /usr/bin/clamscan -d /clamavdb -vr ${SCAN_DIR} --log=$LOG_FILE; then
        	echo "Scan completed, detailed report in $LOG_FILE"
        	exit 0
	else
		echo "Scan detected infected files, see $LOG_FILE for details"
		exit 1
	fi
else
	echo "Missing mandatory parameters"
	exit 1
fi


#!/bin/bash
# setup apache
mkdir -p $ALM_ETC_DIR
for FILE in $(ls -F -I *.conf etc | grep -v /)
do
  cp "etc/${FILE}" ${ALM_ETC_DIR}/
done


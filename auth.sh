#! /bin/bash
name="id":$IKE_REMOTE_EAP_ID
flag=$(redis-cli -h redis-16738.c1.asia-northeast1-1.gce.cloud.redislabs.com -p 16738 -a Mooc1988 get $name)
if [ "$flag" != "" ]
then
  exit 0
else
  exit -1
fi
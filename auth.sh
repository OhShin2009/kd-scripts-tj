#! /bin/bash
name="id":$IKE_REMOTE_EAP_ID
flag=$(redis-cli  get $name)
if [ "$flag" != "" ]
then
  exit 0
else
  exit -1
fi
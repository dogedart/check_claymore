#!/bin/bash
#check_claymore will connect to Claymore GPU miner via the specified port and retreive JSON data to monitor GPU Hash per GPU and total Hashrate
# JSON processor and Bench Calc are used in the processing.  Install -- apt-get install jq bc
# Share and enjoy


rigaddr="192.168.1.100"  #Define Rig IP Address
claymoreport="3333" #Define Claymore remote port
claymoredata="check_claymore_json.tmp" #Define Claymore json data to process

echo '{"id":0,"jsonrpc":"2.0","method":"miner_getstat1"}' | nc $rigaddr $claymoreport > $claymoredata  #pull claymore miner_getstat1 and store


GPU0=`cat $claymoredata | jq -r '.result' | jq '.[3]' | sed -e "s/\"//g" | awk -F ";" '{print $1}' `
GPU1=`cat $claymoredata | jq -r '.result' | jq '.[3]' | sed -e "s/\"//g" | awk -F ";" '{print $2}' `
GPU2=`cat $claymoredata | jq -r '.result' | jq '.[3]' | sed -e "s/\"//g" | awk -F ";" '{print $3}' `
GPU3=`cat $claymoredata | jq -r '.result' | jq '.[3]' | sed -e "s/\"//g" | awk -F ";" '{print $4}' `
GPU4=`cat $claymoredata | jq -r '.result' | jq '.[3]' | sed -e "s/\"//g" | awk -F ";" '{print $5}' `
GPU5=`cat $claymoredata | jq -r '.result' | jq '.[3]' | sed -e "s/\"//g" | awk -F ";" '{print $6}' `
ethtotal=`cat $claymoredata | jq -r '.result' | jq '.[2]' | sed -e "s/\"//g" | awk -F ";" '{print $1}'`
dtotal=`cat $claymoredata | jq -r '.result' | jq '.[4]' | sed -e "s/\"//g" | awk -F ";" '{print $1}'`
temp0=`cat $claymoredata | jq -r '.result' | jq '.[6]' | sed -e "s/\"//g" | awk -F ";" '{print $1}'`
temp1=`cat $claymoredata | jq -r '.result' | jq '.[6]' | sed -e "s/\"//g" | awk -F ";" '{print $3}'`
temp2=`cat $claymoredata | jq -r '.result' | jq '.[6]' | sed -e "s/\"//g" | awk -F ";" '{print $5}'`
temp3=`cat $claymoredata | jq -r '.result' | jq '.[6]' | sed -e "s/\"//g" | awk -F ";" '{print $7}'`
temp4=`cat $claymoredata | jq -r '.result' | jq '.[6]' | sed -e "s/\"//g" | awk -F ";" '{print $9}'`
temp5=`cat $claymoredata | jq -r '.result' | jq '.[6]' | sed -e "s/\"//g" | awk -F ";" '{print $11}'`


GPU0bc=`echo "scale=2;$GPU0/1000" | bc`
GPU1bc=`echo "scale=2;$GPU1/1000" | bc`
GPU2bc=`echo "scale=2;$GPU2/1000" | bc`
GPU3bc=`echo "scale=2;$GPU3/1000" | bc`
GPU4bc=`echo "scale=2;$GPU4/1000" | bc`
GPU5bc=`echo "scale=2;$GPU5/1000" | bc`
ethtotalbc=`echo "scale=2;$ethtotal/1000" | bc`
dtotalbc=`echo "scale=2;$dtotal/1000" | bc`

MESSAGE="GPU0=$GPU0bc GPU1=$GPU1bc GPU2=$GPU2bc GPU3=$GPU3bc GPU4=$GPU4bc GPU5=$GPU5bc ETHHASH=$ethtotalbc DHASH=$dtotalbc $temp0 $temp1 $temp2 $temp3 $temp4 $temp5"
PERFDATA="ETHHASH=$ethtotalbc;;;; DHASH=$dtotalbc;;;; GPU0=$GPU0bc;;;; GPU1=$GPU1bc;;;; GPU2=$GPU2bc;;;; GPU3=$GPU3bc;;;; GPU4=$GPU4bc;;;; GPU5=$GPU5bc;;;; GPU0t=$temp0;;;; GPU1t=$temp1;;;; GPU2t=$temp2;;;; GPU3t=$temp3;;;; GPU4t=$temp4;;;; GPU5t=$temp5;;;;"
echo $MESSAGE " |" $PERFDATA

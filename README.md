# check_claymore
Nagios check to monitor Claymore GPU miner

Prereq
JSON processor (jq) and Bench Calc (bc)


apt-get install jq

apt-get install bc


# Sample

#The JSON data that gets processed looks something like this below. 

cat check_claymore_json.tmp

{"id": 0, "result": ["11.0 - ETH", "1142", "150957;936;0", "25082;25109;28779;22680;25043;24263", "1150101;6296;22", "200660;200876;172675;181440;200346;194104", "56;83;57;83;78;83;48;83;59;83;64;83", "eth-us-west1.nanopool.org:9999;pool-eu.smartcash.cc:3333", "29;0;0;0"], "error": null}

# check_claymore.sh output

# ./check_claymore.sh
GPU0=25.08 GPU1=25.10 GPU2=28.77 GPU3=22.68 GPU4=25.04 GPU5=24.26 ETHHASH=150.95 DHASH=1150.10 56 57 78 48 59 64  | ETHHASH=150.95;;;; DHASH=1150.10;;;; GPU0=25.08;;;; GPU1=25.10;;;; GPU2=28.77;;;; GPU3=22.68;;;; GPU4=25.04;;;; GPU5=24.26;;;; GPU0t=56;;;; GPU1t=57;;;; GPU2t=78;;;; GPU3t=48;;;; GPU4t=59;;;; GPU5t=64;;;;

# TO DO

Add Nagios Logic for warning and critical

Add a variable to define amount of GPUs in system

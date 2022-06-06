#!/bin/bash
mem=$(free -h | awk 'NR==2{print $5}')
echo $mem
cat << EOF
yes
no
EOF
read -t 20 -p "shu ru can shu: " a
case ${a} in
   yes)
      echo 3 > /proc/sys/vm/drop_caches
      echo "<==========cleaning==========>"
      echo "$( free -h | awk 'NR==2{print $4}')"
      echo "<<==========END===========>"
;;
   no)
      echo "<===========thanks===========>"
      echo "$( free -h | awk 'NR==2{print $4}')"
;;
   *)
      echo "can shu bu zheng que"
      exit 1
esac
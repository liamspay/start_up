#!/bin/bash
expr_time=$(date)
expr_email="send-email-to-sbi"
now=$(date +%s%3N)
mili=$(expr 1 \* 3600000)
b1now=$(expr $now - $mili)
echo -e "Last refresh: $expr_time"

#BCA account monitoring
# echo "-------------"
# echo -e "brokerSpecificCode for BCA prod:"
# for i in 0407 0418 0416 0201
# do
#     count=$(aws logs filter-log-events --log-group-name urhub-prod-urhub-bca-service-logs --start-time $b1now --filter-pattern "{ $.responseStatus.brokerSpecificCode = $i }" | wc -l)
#     if [ $count -eq 0  ]
#     then
#       echo -e "\e[32m$i\e[0m - \e[32m$count\e[0m"
#     else
#       echo -e "\e[31;1;4m>[$i - $count]<\e[0m"
#     fi
# done|column -t

#bank count error
echo "-------------"
for i in acleda bca bri cbbank city-express coinsph moneygram sacombank scb tpbank tranglo union-pay vietin gcash scheduler xcurrent-scheduler
do
    count=$(aws logs filter-log-events --log-group-name urhub-prod-urhub-$i-service-logs --start-time $b1now --filter-pattern "ERROR -TRACE -DEBUG -INFO" | grep ERROR  | wc -l)
    if [ $count -eq 0  ]
    then
      echo -e "\e[32m$i\e[0m - \e[32m$count\e[0m"
    elif [ $count -gt 10 ]
    then
      echo -e "\e[41;1;5m>>>[$i - $count]-$expr_email<<<\e[0m"
    else
      echo -e "\e[31;1;4m>[$i - $count]<\e[0m"
    fi
done|column -t

# gateway http error: none 200 code
gatewayerrStr=$(aws logs filter-log-events --log-group-name urhub-prod-urhub-gateway-service-logs --log-stream-names urhub-prod-api-ec2-0_access-log urhub-prod-api-ec2-1_access-log  urhub-prod-api-ec2-2_access-log --start-time $b1now --filter-pattern -' 200 ')
echo -e "-------------"
echo -e "api_http_errors:"
        ## formating messages and highlight (red) unionpay & shared
http_output=$(sed 's/urhub-prod-api-ec2/\nGATEWAY/g' <<< $gatewayerrStr)
http_output=$(sed 's/_access-log/:/g' <<< $http_output)
http_output=$(sed 's/unionpay/\\033[0;31munionpay\\033[0m/g' <<< $http_output)
http_output=$(sed 's/shared/\\033[0;31mshared\\033[0m/g' <<< $http_output)
http_output=$(sed '/EVENTS/d' <<< $http_output)
http_output=$(sed '/SEARCHEDLOGSTREAMS/d' <<< $http_output)
http_output=$(sed '/True/d' <<< $http_output)
echo -e  "${http_output}"

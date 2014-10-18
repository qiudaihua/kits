#!/bin/bash
#echo -e "\033[字背景颜色；文字颜色m字符串\033[0m" 
#echo -e “\033[30m 黑色字 \033[0m” 
#echo -e “\033[31m 红色字 \033[0m” 
#echo -e “\033[32m 绿色字 \033[0m” 
#echo -e “\033[33m 黄色字 \033[0m” 
#echo -e “\033[34m 蓝色字 \033[0m” 
#echo -e “\033[35m 紫色字 \033[0m” 
#echo -e “\033[36m 天蓝字 \033[0m” 
#echo -e “\033[37m 白色字 \033[0m” 

function check_arg() {
  local VALUE="$1"
  local i
  shift
  for i in "$@"; do
    echo "i=$i"
  done
}

check_arg $*




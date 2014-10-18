#!/bin/bash
#echo -e "\033[字背景颜色；文字颜色m字符串\033[0m" 
#echo -e "\033[30m 黑色字 \033[0m" 
#echo -e "\033[31m 红色字 \033[0m" 
#echo -e "\033[32m 绿色字 \033[0m" 
#echo -e "\033[33m 黄色字 \033[0m" 
#echo -e "\033[34m 蓝色字 \033[0m" 
#echo -e "\033[35m 紫色字 \033[0m" 
#echo -e "\033[36m 天蓝字 \033[0m" 
#echo -e "\033[37m 白色字 \033[0m" 

function echo_color() {
    local STRING=""
    local COLOR="30" #black
    case $1 in
        -r | --red)
            COLOR="31"
	        ;;
        -g | --green)
	        COLOR="32"
	        ;;
        -y | --yellow)
	        COLOR="33"
	        ;;
        -b | --blue)
	        COLOR="34"
	        ;;
        -p | --purple)
	        COLOR="35"
	        ;;
    esac
    
    shift
    STRING=$*
    echo -e "\033[${COLOR}m${STRING}\033[0m"
}

echo_color $*




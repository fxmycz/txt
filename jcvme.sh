#!/bin/bash
# 如果没有从外部提供PORT1和PORT2变量，则设置默认值
PORT1=${PORT1:-12345}
# 函数：检查端口是否在监听
check_port() {
    local PORT=$1
    if sockstat -l | grep -q ":$PORT"; then
        echo "Port $PORT is already in use. No action needed."
        return 1  # 返回1表示端口正在使用
    else
        echo "Port $PORT is not in use."
        return 0  # 返回0表示端口未被使用
    fi
}

# 检查PORT1
check_port $PORT1
PORT1_IN_USE=$?  # 保存返回值

# 根据端口状态决定是否执行相应的脚本
if [[ $PORT1_IN_USE -eq 0 ]]; then
    echo "Port $PORT1 is not in use. Executing vme.sh..."
#   PORT=$PORT1 bash /home/hw1/vme.sh
    PORT=$PORT1 bash vme.sh
fi

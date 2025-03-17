#!/bin/bash

# 定义要监控的用户
target_user="user"

# 定义gpustat命令
gpustat_command="gpustat -p"

# 定义日志文件路径
log_file="monitor_gpu_log"

# 实时查询gpustat并处理输出
while true; do
    # 执行gpustat命令并获取输出
    output=$($gpustat_command)
    
    # 检查输出中是否包含目标用户
    if echo "$output" | grep -q "$target_user"; then
        # 提取包含目标用户的行
        user_line=$(echo "$output" | grep "$target_user")
        
        # 提取pid
        pids=$(echo "$user_line" | grep -oP "$target_user/\K\d+")
	    echo $pids
        for pid in $pids; do
        
            # 检查是否成功提取pid
            if [ -n "$pid" ]; then

                # 执行ps命令获取进程信息
                ps_info=$(ps -p "$pid" -o pid,ppid,cmd)
                # 获取进程的工作目录
                cwd=$(ls -l /proc/"$pid"/cwd | awk '{print $NF}')
                # 获取可执行文件路径
                exe=$(ls -l /proc/"$pid"/exe | awk '{print $NF}')
                
                # 将信息写入日志文件
                echo "[$(date)] Detected GPU usage by user: $target_user" >> "$log_file"
                echo "PID: $pid" >> "$log_file"
                echo "Running Directory: $cwd" >> "$log_file"
                echo "Parent PID: $(echo "$ps_info" | awk 'NR==2 {print $2}')" >> "$log_file"
                echo "Executable: $exe" >> "$log_file"
                echo "Command: $(echo "$ps_info" | awk 'NR==2 {print $3}')" >> "$log_file"
                echo "----------------------------------------" >> "$log_file"
            
            else
                echo "未能提取到pid"
            echo "Failed to extract PID for user $target_user at $(date)" >> "$log_file"
            fi
        done
    else
        echo "未找到用户 $target_user 的进程"
    fi
    
    # 等待一段时间后再次查询
    sleep 15
done

# GPU-Usage-Monitor

一个用于监控和记录GPU异常使用情况的脚本。该脚本可以检测指定用户的GPU使用情况，并记录相关的进程信息，包括PID、运行目录、父PID以及可执行文件等信息。

## 功能特点

- 实时监控GPU使用情况
- 检测指定用户的GPU使用
- 记录异常使用情况到日志文件
- 详细记录进程信息，包括PID、运行目录、父PID和可执行文件

## 使用方法

### 克隆仓库

```bash
git clone https://github.com/yourusername/GPU-Usage-Monitor.git
cd GPU-Usage-Monitor
```

### 脚本运行

1. 确保已安装`gpustat`工具。如果未安装，可以通过以下命令安装（以Ubuntu为例）：
    ```bash
    pip install gpustat
    ```

2. 给脚本添加可执行权限：
    ```bash
    chmod +x monitor_gpu.sh
    ```

3. 运行脚本：
    ```bash
    ./monitor_gpu.sh
    ```

### 参数说明

- 脚本会自动在后台运行，并定期检查GPU使用情况。
- 日志文件会保存在脚本所在目录下的`gpu_usage_log.txt`文件中。

## 日志文件格式

日志文件会记录以下信息：
- 检测时间
- 用户名
- PID
- 运行目录
- 父PID
- 可执行文件路径
- 其他相关进程信息

## 示例日志

```plaintext
[2024-05-20 15:30:45] Detected GPU usage by user: wx
PID: 12345
Running Directory: /home/wx/mining_script
Parent PID: 67890
Executable: /usr/bin/python3
Command: python3 -a octopus -o stratum+ssl://example.com:41170 -u wallet_address
----------------------------------------
```

## 注意事项

- 确保运行脚本的用户具有足够的权限访问GPU相关信息和进程信息。
- 如果需要监控其他用户，请修改脚本中的`target_user`变量。
- 日志文件会随着时间增长，建议定期备份和清理。

## 贡献

欢迎提交Pull Request或Issue来改进和完善该项目。

## 许可证

本项目采用MIT许可证。


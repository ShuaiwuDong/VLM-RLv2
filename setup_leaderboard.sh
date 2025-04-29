#!/bin/bash

# 创建工作目录
mkdir -p /home/jerry/VLM-RL/leaderboard_ws
cd /home/jerry/VLM-RL/leaderboard_ws

# 克隆Leaderboard和ScenarioRunner
git clone https://github.com/carla-simulator/leaderboard.git
git clone https://github.com/carla-simulator/scenario_runner.git

# 先安装基本依赖，避免NumPy构建问题
pip install --upgrade pip
pip install wheel setuptools
pip install numpy==1.20.3 scipy==1.7.1 matplotlib==3.4.3 

# 安装其他依赖，但跳过已安装的包
pip install --no-deps -r leaderboard/requirements.txt
pip install --no-deps -r scenario_runner/requirements.txt

# 手动安装常见的依赖
pip install pygame networkx opencv-python pillow psutil shapely xmlschema ephem six tenacity tabulate distro

# 添加必要的环境变量到.bashrc
echo 'export CARLA_ROOT=/home/jerry/VLM-RL/CARLA_0.9.13' >> ~/.bashrc
echo 'export SCENARIO_RUNNER_ROOT=/home/jerry/VLM-RL/leaderboard_ws/scenario_runner' >> ~/.bashrc
echo 'export LEADERBOARD_ROOT=/home/jerry/VLM-RL/leaderboard_ws/leaderboard' >> ~/.bashrc
echo 'export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla' >> ~/.bashrc
echo 'export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg' >> ~/.bashrc
echo 'export PYTHONPATH=$PYTHONPATH:$SCENARIO_RUNNER_ROOT' >> ~/.bashrc
echo 'export PYTHONPATH=$PYTHONPATH:$LEADERBOARD_ROOT' >> ~/.bashrc

# 也设置当前会话的环境变量
export CARLA_ROOT=/home/jerry/VLM-RL/CARLA_0.9.13
export SCENARIO_RUNNER_ROOT=/home/jerry/VLM-RL/leaderboard_ws/scenario_runner
export LEADERBOARD_ROOT=/home/jerry/VLM-RL/leaderboard_ws/leaderboard
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg
export PYTHONPATH=$PYTHONPATH:$SCENARIO_RUNNER_ROOT
export PYTHONPATH=$PYTHONPATH:$LEADERBOARD_ROOT

echo "安装完成！请检查是否有错误消息。"
echo "您可能需要运行 'source ~/.bashrc' 或重新打开终端以使环境变量生效。"

# 检查egg文件是否存在，不存在则发出警告
if [ ! -f "$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg" ]; then
    echo "警告：CARLA Python API egg文件未找到。请确认您的CARLA安装路径是否正确。"
    echo "您可能需要手动调整setup_leaderboard.sh中的CARLA_ROOT路径或检查egg文件的位置。"
fi

#!/bin/bash

# 设置环境变量
export CARLA_ROOT=/home/jerry/VLM-RL/CARLA_0.9.13
export SCENARIO_RUNNER_ROOT=/home/jerry/VLM-RL/leaderboard_ws/scenario_runner
export LEADERBOARD_ROOT=/home/jerry/VLM-RL/leaderboard_ws/leaderboard
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg
export PYTHONPATH=$PYTHONPATH:$SCENARIO_RUNNER_ROOT
export PYTHONPATH=$PYTHONPATH:$LEADERBOARD_ROOT
export PYTHONPATH=$PYTHONPATH:/home/jerry/VLM-RL

# 指定结果保存路径
RESULTS_DIR=/home/jerry/VLM-RL/leaderboard_results
mkdir -p $RESULTS_DIR

# 运行Leaderboard评估 - 连接到已运行的CARLA服务器(端口2000)
python3 ${LEADERBOARD_ROOT}/leaderboard/leaderboard_evaluator.py \
  --scenarios=${LEADERBOARD_ROOT}/data/all_towns_traffic_scenarios_public.json \
  --routes=${LEADERBOARD_ROOT}/data/routes_devtest.xml \
  --repetitions=1 \
  --agent=/home/jerry/VLM-RL/leaderboard_agent/vlm_agent.py \
  --agent-config=/home/jerry/VLM-RL/leaderboard_agent/vlm_agent.json \
  --track=SENSORS \
  --checkpoint=${RESULTS_DIR}/results.json \
  --port=2000 \
  --timeout=120.0

echo "评估完成，结果保存在 ${RESULTS_DIR}/results.json"

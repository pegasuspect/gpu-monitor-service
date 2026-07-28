#!/bin/bash
mkdir -p /var/log/gpu-monitor

while IFS= read -r line; do
  timestamp=${line%%,*}
  values=${line#*,}
  timestamp=${timestamp//\//-}
  file="/var/log/gpu-monitor/gpu-test-${timestamp:0:10}.csv"

  if [[ ! -s $file ]]; then
    echo "time,temperature.gpu,utilization.gpu,memory.used,power.draw,clocks.gr,clocks.mem" > "$file"
  fi

  echo "$timestamp,$values" >> "$file"
done < <(
  exec nvidia-smi \
    --query-gpu=timestamp,temperature.gpu,utilization.gpu,memory.used,power.draw,clocks.gr,clocks.mem \
    --format=csv,noheader,nounits --loop=1
)
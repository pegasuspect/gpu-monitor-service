# NVIDIA GPU monitor installation

This service records one sample per second and automatically changes CSV files
at midnight in `America/New_York`. Each file is capped at 86,400 total lines,
including its header. On an unusually long day or after unusually fast sampling,
additional data goes into `-part2.csv` instead of exceeding that limit.

## Install

Run these commands from the extracted package directory:

```bash
sudo install -m 0755 gpu-monitor.sh /usr/local/sbin/gpu-monitor.sh
sudo install -m 0644 gpu-monitor.service /etc/systemd/system/gpu-monitor.service
sudo install -d -m 0755 /var/log/gpu-monitor
sudo systemctl daemon-reload
sudo systemctl enable --now gpu-monitor.service
```

## Verify

```bash
systemctl status gpu-monitor.service
ls -lh /var/log/gpu-monitor/
tail -n 5 /var/log/gpu-monitor/gpu-test-$(date +%F).csv
```

The service intentionally prints nothing to the terminal. Errors are available
with:

```bash
journalctl -u gpu-monitor.service
```

## Common operations

```bash
sudo systemctl restart gpu-monitor.service
sudo systemctl stop gpu-monitor.service
sudo systemctl start gpu-monitor.service
```

## Uninstall

This leaves existing CSV logs intact:

```bash
sudo systemctl disable --now gpu-monitor.service
sudo rm /etc/systemd/system/gpu-monitor.service
sudo rm /usr/local/sbin/gpu-monitor.sh
sudo systemctl daemon-reload
```

Delete `/var/log/gpu-monitor` separately only if you no longer want its logs.

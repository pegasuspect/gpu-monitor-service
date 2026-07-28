systemctl disable --now gpu-monitor.service
rm /etc/systemd/system/gpu-monitor.service
rm /usr/local/sbin/gpu-monitor.sh
systemctl daemon-reload
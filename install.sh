install -m 0755 gpu-monitor.sh /usr/local/sbin/gpu-monitor.sh
install -m 0644 gpu-monitor.service /etc/systemd/system/gpu-monitor.service
install -d -m 0755 /var/log/gpu-monitor
systemctl daemon-reload
systemctl enable --now gpu-monitor.service
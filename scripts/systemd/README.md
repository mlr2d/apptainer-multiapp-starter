# systemd Integration

Systemd unit for starting and stopping the full stack using:
- `scripts/start-all.sh`
- `scripts/stop-all.sh`

## Install (system-wide)
```bash
sudo cp /home/sankaran2/apps/apptainer-multiapp-starter/scripts/systemd/apptainer-stack.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable apptainer-stack
sudo systemctl start apptainer-stack
sudo systemctl status apptainer-stack
```

## Install (per-user)
```bash
mkdir -p ~/.config/systemd/user
cp /home/sankaran2/apps/apptainer-multiapp-starter/scripts/systemd/apptainer-stack.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable apptainer-stack
systemctl --user start apptainer-stack
systemctl --user status apptainer-stack
```

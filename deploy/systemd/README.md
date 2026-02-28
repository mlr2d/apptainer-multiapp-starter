# systemd Integration

This folder contains `apptainer-stack.service`, a unit template that starts and stops all services through:
- `scripts/start-all.sh`
- `scripts/stop-all.sh`

## Usage modes

### System-wide service
Install to:
- `/etc/systemd/system/apptainer-stack.service`

Commands:
```bash
sudo cp /home/sankaran2/apps/apptainer-multiapp-starter/deploy/systemd/apptainer-stack.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable apptainer-stack
sudo systemctl start apptainer-stack
sudo systemctl status apptainer-stack
```

### Per-user service
Install to:
- `~/.config/systemd/user/apptainer-stack.service`

Commands:
```bash
mkdir -p ~/.config/systemd/user
cp /home/sankaran2/apps/apptainer-multiapp-starter/deploy/systemd/apptainer-stack.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable apptainer-stack
systemctl --user start apptainer-stack
systemctl --user status apptainer-stack
```

## Operational commands
System-wide:
```bash
sudo systemctl start apptainer-stack
sudo systemctl stop apptainer-stack
sudo systemctl restart apptainer-stack
sudo systemctl status apptainer-stack
```

Per-user:
```bash
systemctl --user start apptainer-stack
systemctl --user stop apptainer-stack
systemctl --user restart apptainer-stack
systemctl --user status apptainer-stack
```

## Notes
- If repository path changes, update `WorkingDirectory`, `ExecStart`, and `ExecStop` in the unit file.
- The unit uses `Type=oneshot` + `RemainAfterExit=yes` so systemd tracks stack state after start script exits.

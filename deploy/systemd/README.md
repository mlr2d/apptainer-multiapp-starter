# systemd usage for Apptainer stack

This folder contains `apptainer-stack.service`, a unit that starts/stops all app instances using:
- `scripts/start-all.sh`
- `scripts/stop-all.sh`

## Where to place the service file

Choose one mode.

### 1) System-wide service (recommended for server startup)
- Copy to: `/etc/systemd/system/apptainer-stack.service`

Commands:
```bash
sudo cp /home/sankaran2/apps/test3/deploy/systemd/apptainer-stack.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable apptainer-stack
sudo systemctl start apptainer-stack
sudo systemctl status apptainer-stack
```

### 2) Per-user service (no root, runs only for that user)
- Copy to: `~/.config/systemd/user/apptainer-stack.service`

Commands:
```bash
mkdir -p ~/.config/systemd/user
cp /home/sankaran2/apps/test3/deploy/systemd/apptainer-stack.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable apptainer-stack
systemctl --user start apptainer-stack
systemctl --user status apptainer-stack
```

## Start/stop/status

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
- Ensure `/home/sankaran2/apps/test3/scripts/*.sh` are executable.
- If you change the project path, update `WorkingDirectory`, `ExecStart`, and `ExecStop` in the service file.
- The unit is `Type=oneshot` with `RemainAfterExit=yes`, so it runs start/stop scripts and tracks state even after scripts exit.

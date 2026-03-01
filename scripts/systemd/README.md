# systemd Integration

Template unit for managing the full Apptainer stack with:
- `scripts/start-all.sh`
- `scripts/stop-all.sh`

## System-wide install
```bash
sudo cp /home/sankaran2/apps/apptainer-multiapp-starter/scripts/systemd/apptainer-stack.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable apptainer-stack
sudo systemctl start apptainer-stack
sudo systemctl status apptainer-stack
```

## Per-user install
```bash
mkdir -p ~/.config/systemd/user
cp /home/sankaran2/apps/apptainer-multiapp-starter/scripts/systemd/apptainer-stack.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable apptainer-stack
systemctl --user start apptainer-stack
systemctl --user status apptainer-stack
```

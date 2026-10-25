# Level 4: Systemd Daemons, System Services & Cron Automation

## Track Overview
In Levels 1 through 3, you learned how to navigate files, configure security permissions, monitor process hierarchies, and dispatch POSIX signals. However, running processes directly from an interactive shell has a fatal flaw: **if the terminal window closes or the server reboots, your application dies.**

Level 4 teaches the industry standard for production service management on modern Linux:
1. **Systemd Architecture (PID 1)**: How Linux boots, targets, and manages unit dependencies.
2. **Writing Unit Files (`.service`)**: Crafting hardened, auto-healing systemd services.
3. **Service Lifecycle Operations**: Safe starting, stopping, reloading, and boot enabling with `systemctl`.
4. **Structured Binary Logging**: Centralized observability and live log streaming with `journalctl`.
5. **Periodic Task Scheduling**: Reliable automated tasks with `cron` and `crontab`.

---

## Lesson 4.1 — Systemd Architecture vs Legacy Init

### 1. Why Systemd Replaced SysVinit
Older Linux distributions used **SysVinit** with shell scripts in `/etc/init.d/`. SysVinit was slow, sequential, and brittle:
- No automatic service dependency tracking.
- If a background daemon crashed, SysVinit had no built-in mechanism to restart it.
- Process tracking relied on unreliable PID files (`/var/run/app.pid`).

**Systemd** solves this as the mother of all processes (**PID 1**):
- **Cgroup Tracking**: Tracks every subprocess inside a Linux Control Group (`cgroup`). If a worker fork crashes, systemd detects it instantly.
- **Parallel Bootstrapping**: Starts independent services concurrently, dramatically reducing server boot time.
- **On-Demand Activation**: Supports socket activation, timer units, and mount tracking.

### 2. Unit Types & Targets
Everything managed by systemd is a **Unit**:
- `.service`: Background daemons (Gunicorn, Nginx, PostgreSQL).
- `.target`: Synchronization points grouping multiple units (similar to legacy runlevels):
  - `multi-user.target`: Standard non-graphical server multi-user environment.
  - `graphical.target`: Desktop GUI environment.
  - `default.target`: Default target booted by the system (usually a symlink to `multi-user.target`).
- `.socket`: IPC or network sockets for on-demand daemon launch.
- `.timer`: Systemd-native timer for scheduled jobs (alternative to cron).

```bash
# Check current default boot target
systemctl get-default

# List all active running service units
systemctl list-units --type=service --state=running
```

---

## Lesson 4.2 — Writing Production `.service` Units

To turn any Python, Flask, Node, or Go application into a system-managed daemon, you create a declarative unit file in `/etc/systemd/system/<service-name>.service`.

### Production Unit Example: `/etc/systemd/system/teachcloud.service`

```ini
[Unit]
Description=TeachCloud Flask Production Daemon
After=network.target
Wants=network-online.target

[Service]
Type=simple
User=appuser
Group=appgroup
WorkingDirectory=/home/ubuntu/teachcloud
Environment="PATH=/home/ubuntu/teachcloud/.venv/bin"
EnvironmentFile=/home/ubuntu/teachcloud/.env.production
ExecStart=/home/ubuntu/teachcloud/.venv/bin/gunicorn --workers 4 --bind 127.0.0.1:5000 --access-logfile - --error-logfile - wsgi:app
ExecReload=/bin/kill -s HUP $MAINPID
Restart=always
RestartSec=5s
KillMode=mixed
TimeoutStopSec=30s
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
```

### Key Directives Explained:
- `After=network.target`: Ensures networking stack is initialized before starting this application.
- `User=appuser`: **Security safeguard!** Never run web servers as `root`.
- `Restart=always`: If Gunicorn crashes or gets killed by OOM, systemd will automatically revive it.
- `RestartSec=5s`: Waits 5 seconds before reviving to prevent crash loops from hammering the CPU.
- `WantedBy=multi-user.target`: Tells systemd to enable this service when the server reaches standard multi-user mode.

### Loading New Services
Whenever you create or modify a `.service` file, you **must notify systemd** to reload unit configurations from disk:
```bash
sudo systemctl daemon-reload
```

---

## Lesson 4.3 — Service Lifecycle Management (`systemctl`)

The `systemctl` utility is your primary tool for managing services.

### Core Operations Matrix

| Command | Action | DevOps Context |
|---|---|---|
| `sudo systemctl start teachcloud` | Starts service immediately | Used after deployment |
| `sudo systemctl stop teachcloud` | Gracefully terminates service | Maintenance windows |
| `sudo systemctl restart teachcloud` | Stops then starts daemon | Applying code updates |
| `sudo systemctl reload teachcloud` | Sends `SIGHUP` reload | Zero-downtime config refresh |
| `sudo systemctl status teachcloud` | Checks health, PID, logs | Primary diagnostic command |
| `sudo systemctl enable teachcloud` | Enables boot startup | Creates symlink in `multi-user.target.wants` |
| `sudo systemctl disable teachcloud` | Disables boot startup | Removes startup symlink |
| `sudo systemctl enable --now <unit>`| Enables AND starts in 1 step | Cloud-init provisioning |

### Reading `systemctl status` Output
```text
● teachcloud.service - TeachCloud Flask Production Daemon
     Loaded: loaded (/etc/systemd/system/teachcloud.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2026-10-20 10:00:00 UTC; 2h 45min ago
   Main PID: 1420 (gunicorn)
      Tasks: 5 (limit: 4668)
     Memory: 182.4M
        CPU: 1.250s
     CGroup: /system.slice/teachcloud.service
             ├─1420 /home/ubuntu/teachcloud/.venv/bin/python3 ... gunicorn: master
             ├─1421 gunicorn: worker [1]
             ├─1422 gunicorn: worker [2]
             ├─1423 gunicorn: worker [3]
             └─1424 gunicorn: worker [4]
```

---

## Lesson 4.4 — Centralized Systemd Journal Observability (`journalctl`)

Systemd consolidates standard output (`stdout`) and standard error (`stderr`) from all services into a high-performance binary log store: `systemd-journald`.

### Why `journalctl` is Superior to Plain Text Logs:
- Centralized: No searching across 20 different `/var/log/*` directories.
- Tamper-Resistant: Binary format prevents accidental line truncations.
- Structured Metadata: Every line is tagged with unit name, PID, timestamp, and severity priority.

### Production Journal Recipes

```bash
# 1. Live stream logs (like tail -f) for a specific service
journalctl -u teachcloud -f

# 2. View only logs generated in the past 2 hours
journalctl -u teachcloud --since "2 hours ago"

# 3. View logs between specific ISO timestamps
journalctl -u teachcloud --since "2026-10-20 08:00:00" --until "2026-10-20 10:30:00"

# 4. Audit critical boot & kernel errors (Priority: err, crit, alert, emerg)
journalctl -p err -b

# 5. Limit output to last 50 lines without opening pager
journalctl -u teachcloud -n 50 --no-pager
```

---

## Lesson 4.5 — Scheduled Automation with Cron

When tasks need to run periodically (e.g. database backups, TLS certificate renewals, log purges) rather than continuously as daemons, **Cron** is the time-tested standard.

### The 5-Field Cron Syntax:
```text
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday)
│ │ │ │ │
* * * * *  /path/to/executable/command
```

### Essential Production Cron Expressions:
- `0 2 * * *`: Every night at 02:00 AM (e.g., nightly database dump).
- `*/15 * * * *`: Every 15 minutes (e.g., cache synchronization).
- `0 0 * * 0`: Every Sunday at midnight (e.g., weekly log archiving).
- `0 0 1 * *`: 1st day of every month at midnight (e.g., monthly billing roll).
- `@reboot`: Runs once immediately upon system boot.

### Managing Cron Tables:
```bash
# View active user's cron schedule
crontab -l

# Edit user's crontab safely
crontab -e

# Golden Rule for Cron Jobs: Always capture stdout and stderr to a log file!
0 2 * * * /usr/local/bin/backup_db.sh >> /var/log/backup.log 2>&1
```

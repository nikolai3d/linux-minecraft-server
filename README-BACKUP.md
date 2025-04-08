# Minecraft Bedrock Server: Backup & Screen Setup

This document summarizes the setup for running the Minecraft Bedrock server inside a named `screen` session and performing nightly world backups with cron.

---

## 🖥️ Running Bedrock Server with `screen`

### Systemd Service File

The Bedrock server is managed by `systemd` and launched inside a named `screen` session (`nikolai-bedrock`) to allow console command injection for live backups.

**Path:** `/etc/systemd/system/bedrock.service`

```
[Unit]
Description=Minecraft Bedrock Server
After=network.target

[Service]
WorkingDirectory=/root/bedrock
ExecStart=/usr/bin/screen -DmS nikolai-bedrock /root/bedrock/bedrock_server
ExecStop=/usr/bin/screen -S nikolai-bedrock -X quit
Restart=on-failure
RestartSec=10
User=root

[Install]
WantedBy=multi-user.target
```

### Commands

- Start: `sudo systemctl start bedrock`
- Stop: `sudo systemctl stop bedrock`
- Status: `sudo systemctl status bedrock`
- Attach to screen: `screen -r nikolai-bedrock`
- Detach: `Ctrl + A`, then `D`

---

## 💾 World Backup Setup

### Backup Script

**Path:** `/root/linux-minecraft-server/bedrock-world-backup.sh`

**What it does:**
- Sends `save hold`, `save query`, and `save resume` to the Bedrock server inside the `screen` session
- Archives the `worlds/` directory with a timestamp
- Saves it to `/root/bedrock_backups`
- Deletes backups older than 180 days
- Logs to `/root/bedrock_logs/world_backup.log`

### Cron Job

**Path:** root's crontab

```
0 4 * * * /root/linux-minecraft-server/bedrock-world-backup.sh
```

This runs the backup script daily at **4:00 AM Pacific Time**.

### Time Zone Configuration

Ensure the server is set to Pacific Time:

```bash
timedatectl set-timezone America/Los_Angeles
```

Verify with:

```bash
timedatectl
```

---

## 📁 Backup Output

- Backups are stored in: `/root/bedrock_backups`
- Each file: `bedrock_backup_YYYY-MM-DD_HH-MM-SS.tar.gz`
- Backup log: `/root/bedrock/backup.log`

---

## Status Check Commands:

```bash
sudo systemctl status bedrock
```

should say something like:

```
● bedrock.service - Nikolai Minecraft Bedrock Server
     Loaded: loaded (/etc/systemd/system/bedrock.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2025-04-07 16:02:13 PDT; 25min ago
   Main PID: 2879 (screen)
      Tasks: 16 (limit: 2309)
     Memory: 187.4M
        CPU: 42.795s
     CGroup: /system.slice/bedrock.service
             ├─2879 /usr/bin/SCREEN -DmS nikolai-bedrock /root/bedrock/bedrock_server
             └─2880 /root/bedrock/bedrock_server
```

```bash
screen -ls | grep nikolai-bedrock
```

should say something like:

```
2879.nikolai-bedrock    (04/07/25 16:02:13)     (Detached)
```

---

## ✅ Done

You now have:
- Live world backups with no downtime
- Server running in an easily controllable screen session
- Reliable cron scheduling in the correct time zone
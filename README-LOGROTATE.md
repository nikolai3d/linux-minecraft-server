# Bedrock Server Log Rotation Script

This script rotates and archives the `latest.log` file from the Bedrock server.

## What it does

- Moves `/root/bedrock_logs/latest.log` to `/root/bedrock_logs/archive/daily-YYYY-MM-DD.log.gz`
- Creates a new empty `latest.log` for the server to continue logging
- Automatically deletes archived logs older than 180 days

## Usage

This script is executed daily via cron:
```bash
/etc/cron.daily/bedrock-logrotate
```

You can also run it manually

```bash
bash /root/bedrock_scripts/bedrock-logrotate.sh
```

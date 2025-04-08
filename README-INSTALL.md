# Deployment

Ubuntu 22.04 LTS

# Installation

## Update and install dependencies
```bash
sudo apt update
sudo apt upgrade
sudo apt install unzip curl libcurl4 libssl3 libcrypto++8 libuuid1 libncurses5 libstdc++6 screen -y
sudo reboot
```

## Download Bedrock Server

```bash
mkdir bedrock
cd bedrock
curl -o bedrock-server.zip -A "Mozilla/5.0" https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.71.01.zip
unzip bedrock-server.zip
```

## Create systemd service

```bash
sudo nano /etc/systemd/system/bedrock.service
```

Copy and paste the contents of `bedrock-service.txt` into the file.

## Enable and start the service

```bash
sudo systemctl enable bedrock
sudo systemctl start bedrock
```

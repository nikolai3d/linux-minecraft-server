#!/bin/bash

# Allow SSH so you don't lock yourself out
ufw allow OpenSSH

# Allow Minecraft Bedrock (default port is 19132 UDP)
ufw allow 19132/udp

# Optional: allow IPv6 Bedrock port (some setups use 19133/udp)
ufw allow 19133/udp

# Default policies: block incoming, allow outgoing
ufw default deny incoming
ufw default allow outgoing

# Enable the firewall without prompting
ufw --force enable

# Display status
ufw status verbose

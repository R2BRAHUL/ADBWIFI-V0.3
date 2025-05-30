#!/bin/bash

# Clear screen
clear

# Show installing message
echo -e "\033[1;36m📦 Installing ADB Wi-Fi Tool...\033[0m"
sleep 1

# Detect OS: Termux or Linux
if [[ $PREFIX == "/data/data/com.termux/files/usr" ]]; then
    OS="Termux"
    BIN_PATH="$PREFIX/bin"
    PKG_INSTALL="pkg install -y"
else
    OS="Linux"
    BIN_PATH="/usr/bin"
    PKG_INSTALL="sudo apt install -y"
fi

# Install dependencies
echo -e "\033[1;33m🔍 Installing required packages...\033[0m"
$PKG_INSTALL android-tools figlet lolcat &> /dev/null

# Move script to bin and make executable
chmod +x adbwifi.sh
cp adbwifi.sh $BIN_PATH/adbwifi

# Confirm installation
echo -e "\033[1;32m✅ Installation complete!\033[0m"
echo -e "\033[1;34m👉 Run the tool using: \033[1;37madbwifi\033[0m"

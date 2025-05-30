#!/bin/bash

clear

Check and install dependencies

install_requirements() { echo "🔍 Checking and Installing Required Packages..." | lolcat if ! command -v figlet &>/dev/null; then echo "📦 Installing figlet..." | lolcat pkg install figlet -y || sudo apt install figlet -y fi if ! command -v lolcat &>/dev/null; then echo "📦 Installing lolcat..." | lolcat pkg install ruby -y || sudo apt install ruby -y gem install lolcat fi if ! command -v adb &>/dev/null; then echo "📦 Installing android-tools (ADB)..." | lolcat pkg install android-tools -y || sudo apt install android-tools-adb -y fi }

Show logo and banner

show_banner() { figlet "Cyber7F" | lolcat echo "🔧 ADB over Wi-Fi Automation Framework" | lolcat echo "🔩 Developed by R2BRAHUL | Powered by Cyber7F" | lolcat echo "-------------------------------------------------" | lolcat sleep 1 }

Connect over Wi-Fi

connect_wifi() { echo "🔍 Looking for connected Android device..." | lolcat adb devices sleep 1 DEVICE_STATUS=$(adb devices | sed -n '2p' | awk '{print $2}')

if [ "$DEVICE_STATUS" != "device" ]; then
    echo "❌ No authorized device found!" | lolcat
    echo "📜 Make sure:" | lolcat
    echo "   🔸 USB connected, ADB debugging ON" | lolcat
    echo "   🔸 Authorization accepted on phone" | lolcat
    return
fi

echo "✅ Device Authorized!" | lolcat
adb tcpip 5555
sleep 1
DEVICE_IP=$(adb shell ip -f inet addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)

if [ -z "$DEVICE_IP" ]; then
    echo "❌ IP not found. Make sure Wi-Fi is active." | lolcat
    return
fi

echo "📶 Connecting to: $DEVICE_IP:5555" | lolcat
adb connect "$DEVICE_IP:5555"
adb devices | lolcat

}

ADB Shell

adb_shell() { echo "🧠 Entering ADB Shell..." | lolcat adb shell }

Pull file from device

pull_file() { echo -n "📥 Enter path to file on device: " | lolcat read device_path echo -n "📁 Enter local save path: " | lolcat read local_path adb pull "$device_path" "$local_path" }

Push file to device

push_file() { echo -n "📤 Enter local file path: " | lolcat read local_path echo -n "📁 Enter target path on device: " | lolcat read device_path adb push "$local_path" "$device_path" }

Show device info

device_info() { echo "📱 Getting Device Info..." | lolcat MODEL=$(adb shell getprop ro.product.model) BRAND=$(adb shell getprop ro.product.brand) VERSION=$(adb shell getprop ro.build.version.release) BATTERY=$(adb shell dumpsys battery | grep level | awk '{print $2}') STORAGE=$(adb shell df /data | tail -1 | awk '{print $4}')

echo "📦 Device: $BRAND $MODEL" | lolcat
echo "📱 Android Version: $VERSION" | lolcat
echo "🔋 Battery Level: $BATTERY%" | lolcat
echo "💾 Free Storage: $STORAGE" | lolcat

}

Main Menu

main_menu() { while true; do echo "" echo "📘 Main Menu" | lolcat echo "1️⃣  Connect over Wi-Fi" echo "2️⃣  ADB Shell Access" echo "3️⃣  Pull File from Device" echo "4️⃣  Push File to Device" echo "5️⃣  Exit" echo "6️⃣  Device Info" echo -n "➡️  Choose an option: " read choice

case $choice in
        1) connect_wifi ;;
        2) adb_shell ;;
        3) pull_file ;;
        4) push_file ;;
        5) echo "👋 Exiting... Stay secure!" | lolcat; exit 0 ;;
        6) device_info ;;
        *) echo "❌ Invalid choice!" | lolcat ;;
    esac
done

}

Start

install_requirements show_banner main_menu


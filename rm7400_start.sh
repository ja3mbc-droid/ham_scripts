#!/bin/bash
export PATH=/usr/bin:/bin:/usr/local/bin
export DISPLAY=:0
echo "=== RM7400モード起動 ==="

# rigctld停止
pkill -f rigctld 2>/dev/null
pkill -f wsjtx 2>/dev/null
sleep 1

# COMポート修正
rm -f /home/ja3mbc/.wine/dosdevices/com3
ln -sf /dev/ttyUSB0 /home/ja3mbc/.wine/dosdevices/com3
WINEPREFIX=/home/ja3mbc/.wine wine reg add "HKLM\Software\Wine\Ports" /v COM3 /t REG_SZ /d /dev/ttyUSB0 /f

# 1. Hamlog
WINEPREFIX=/home/ja3mbc/.wine wine /home/ja3mbc/.wine/drive_c/Hamlog/Hamlogw.exe &
sleep 5

# 2. Remote7400
WINEPREFIX=/home/ja3mbc/.wine wine /home/ja3mbc/.wine/drive_c/Hamlog/rm74_290/Remote7400.exe &
sleep 3

# 3. MailQSL
WINEPREFIX=/home/ja3mbc/.wine wine /home/ja3mbc/.wine/drive_c/Hamlog/MailQSL.exe &

echo "=== RM7400モード 起動完了 ==="

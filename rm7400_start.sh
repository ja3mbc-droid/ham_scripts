#!/bin/bash
echo "=== RM7400モード起動 ==="

# rigctld停止（COMポート解放）
if pgrep -x rigctld > /dev/null; then
    echo "⚠️  rigctld停止中..."
    pkill -f rigctld 2>/dev/null
    sleep 2
    echo "✅ rigctld停止完了"
fi

# WSJT-X停止
if pgrep -x wsjtx > /dev/null; then
    echo "⚠️  WSJT-X停止中..."
    pkill -f wsjtx 2>/dev/null
    sleep 2
    echo "✅ WSJT-X停止完了"
fi

# COMポート修正
rm -f ~/.wine/dosdevices/com3
ln -sf /dev/ttyUSB0 ~/.wine/dosdevices/com3
WINEPREFIX=~/.wine wine reg add "HKLM\Software\Wine\Ports" /v COM3 /t REG_SZ /d /dev/ttyUSB0 /f

# 1. Remote7400
if ! pgrep -f Remote7400 > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/rm74_290/Remote7400.exe &
    echo "✅ RM7400 起動完了"
    sleep 5
else
    echo "⚠️  RM7400 起動済み"
fi

# 2. Hamlog（二重起動防止）
if ! pgrep -f Hamlogw.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/Hamlogw.exe &
    echo "✅ Hamlog 起動完了"
    sleep 5
else
    echo "⚠️  Hamlog 起動済み"
fi

# 3. MailQSL（二重起動防止）
if ! pgrep -f MailQSL.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/MailQSL.exe &
    echo "✅ MailQSL 起動完了"
else
    echo "⚠️  MailQSL 起動済み"
fi

echo "=== RM7400モード 起動完了 ==="

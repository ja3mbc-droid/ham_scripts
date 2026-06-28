#!/bin/bash
echo "=== MMSSTVモード起動 ==="

# rigctld停止
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

# Remote7400停止
if pgrep -f Remote7400 > /dev/null; then
    echo "⚠️  Remote7400停止中..."
    pkill -f Remote7400 2>/dev/null
    sleep 2
    echo "✅ Remote7400停止完了"
fi

# COMポート修正
rm -f ~/.wine/dosdevices/com3
ln -sf /dev/ttyUSB0 ~/.wine/dosdevices/com3

# 1. MMSSTV起動
if ! pgrep -f MMSSTV.EXE > /dev/null; then
    cd ~/.wine/drive_c/MMSSTV
    WINEPREFIX=~/.wine wine MMSSTV.EXE &
    echo "✅ MMSSTV 起動完了"
    sleep 5
else
    echo "⚠️  MMSSTV 起動済み"
fi

# 2. Hamlog（二重起動防止）
if ! pgrep -f Hamlogw.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/Hamlogw.exe &
    echo "✅ Hamlog 起動完了"
    sleep 3
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

echo "=== MMSSTVモード 起動完了 ==="

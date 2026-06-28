#!/bin/bash
echo "FreeDVモード起動中..."

# flrig起動（必要なら残す）
if ! pgrep flrig > /dev/null; then
    flrig &
    sleep 5
    echo "✅ flrig起動完了"
else
    echo "⚠️ flrig起動済み"
fi

# FD Linker起動（必要なら残す）
if ! pgrep -f FD_Linker_LIsten_Ver221.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/FD_Linker/FD_linker_Ver2.2.1/FD_Linker_Listen/FD_Linker_LIsten_Ver221.exe &
    sleep 8
    echo "✅ FD Linker起動完了"
else
    echo "⚠️ FD Linker起動済み"
fi

# hamlog_gui 起動
cd ~/hamlog_gui
cargo run &
echo "✅ hamlog_gui 起動完了"

# FreeDV起動
~/freedv_audio_fix.sh
freedv &
echo "✅ FreeDV起動完了"

# Hamlog 起動（FreeDV の後）
wine ~/.wine/drive_c/Hamlog/Hamlogw.exe &
echo "✅ Hamlog 起動完了"


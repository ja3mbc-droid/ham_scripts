#!/bin/bash

echo "FreeDVモード起動中..."

# flrig起動
if ! pgrep flrig > /dev/null; then
    flrig &
    sleep 5
    echo "✅ flrig起動完了"
else
    echo "⚠️ flrig起動済み"
fi

# HAMLOG起動
~/hamlog_start.sh
sleep 5

# FD Linker起動
if ! pgrep -f FD_Linker_LIsten_Ver221.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/FD_Linker/FD_linker_Ver2.2.1/FD_Linker_Listen/FD_Linker_LIsten_Ver221.exe &
    sleep 8
    echo "✅ FD Linker起動完了"
else
    echo "⚠️ FD Linker起動済み"
fi

# オーディオ設定修正
~/freedv_audio_fix.sh

# FreeDV起動
if ! pgrep -x freedv > /dev/null; then
    freedv &
    echo "✅ FreeDV起動完了"
else
    echo "⚠️ FreeDV起動済み"
fi

# MailQSL起動
if ! pgrep -f MailQSL.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/MailQSL.exe &
    echo "✅ MailQSL 起動完了"
else
    echo "⚠️ MailQSL 起動済み"
fi

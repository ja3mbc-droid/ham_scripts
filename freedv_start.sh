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

# ===========================================================
# FD_Linker起動部（2026-07-14 コメントアウト）
# 理由:
# ham_control_v02 は FD_Linker に依存しない設計へ変更。
# FreeDV → ham_control_v02 → freedv_all.txt → QsoRecord → ADIF
# の経路へ移行したため、自動起動を停止する。
# 必要になればコメントを外すことで復元可能。
# ===========================================================
# if ! pgrep -f FD_Linker_LIsten_Ver221.exe > /dev/null; then
#     WINEPREFIX=~/.wine wine ~/.wine/drive_c/FD_Linker/FD_linker_Ver2.2.1/FD_Linker_Listen/FD_Linker_LIsten_Ver221.exe &
#     sleep 8
#     echo "✅ FD Linker起動完了"
# else
#     echo "⚠️ FD Linker起動済み"
# fi
# ----- FD_Linker起動部ここまで -----


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

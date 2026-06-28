#!/bin/bash
echo "=== FT8モード停止 ==="
# WSJT-X を安全に停止
pkill -TERM -f wsjtx 2>/dev/null && echo "✅ WSJT-X 停止" || echo "⚠️  WSJT-X 起動していない"
sleep 2
# JT_Linker を停止
pkill -TERM -f JT_Linker_2023.exe 2>/dev/null && echo "✅ JT_Linker 停止" || echo "⚠️  JT_Linker 起動していない"
sleep 1
# MailQSL を停止
pkill -TERM -f MailQSL.exe 2>/dev/null && echo "✅ MailQSL 停止" || echo "⚠️  MailQSL 起動していない"
sleep 1
# HAMLOG を安全に停止（保存確認ダイアログが出ます）
wmctrl -F -a "Turbo HAMLOG" -c 2>/dev/null && echo "✅ Hamlog 停止シグナル送信" || \
pkill -TERM -f Hamlogw.exe 2>/dev/null && echo "✅ Hamlog 停止" || echo "⚠️  Hamlog 起動していない"
sleep 2
# rigctld を停止
pkill -TERM -x rigctld 2>/dev/null && echo "✅ rigctld 停止" || echo "⚠️  rigctld 起動していない"
sleep 1
# flrig を停止
pkill -TERM -x flrig 2>/dev/null && echo "✅ flrig 停止" || echo "⚠️  flrig 起動していない"
echo "=== FT8モード停止完了 ==="

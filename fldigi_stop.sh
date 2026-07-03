#!/bin/bash
echo "fldigiモード停止中..."

# fldigi停止
ps aux | grep -w fldigi | grep -v grep | awk '{print $2}' | xargs -r kill -9

# flrig停止
ps aux | grep -w flrig | grep -v grep | awk '{print $2}' | xargs -r kill -9

# MailQSL停止
ps aux | grep -w "MailQSL.exe" | grep -v grep | awk '{print $2}' | xargs -r kill -9
echo "✅ MailQSL停止完了"

# Hamlog停止
wmctrl -F -a "Turbo HAMLOG" -c 2>/dev/null && echo "✅ Hamlog停止シグナル送信" || \
pkill -TERM -f Hamlogw.exe 2>/dev/null && echo "✅ Hamlog停止" || echo "⚠️  Hamlog起動していない"

sleep 2
ps aux | grep -w fldigi | grep -v grep && echo "fldigi停止失敗" || echo "✅ fldigi停止完了"
ps aux | grep -w flrig | grep -v grep && echo "flrig停止失敗" || echo "✅ flrig停止完了"

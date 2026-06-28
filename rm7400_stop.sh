#!/bin/bash
echo "=== RM7400モード停止 ==="
pkill -TERM -f Remote7400 2>/dev/null && echo "✅ RM7400 停止" || echo "⚠️  RM7400 起動していない"
sleep 1
pkill -TERM -f MailQSL.exe 2>/dev/null && echo "✅ MailQSL 停止" || echo "⚠️  MailQSL 起動していない"
sleep 1
wmctrl -F -a "Turbo HAMLOG" -c 2>/dev/null || pkill -TERM -f Hamlogw.exe 2>/dev/null
echo "✅ Hamlog 停止シグナル送信"
echo "=== RM7400モード停止完了 ==="

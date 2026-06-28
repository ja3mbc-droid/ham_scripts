#!/bin/bash
echo "=== MMSSTV停止 ==="

# MMSSTV停止
if pgrep -f MMSSTV.EXE > /dev/null; then
    pkill -f MMSSTV.EXE 2>/dev/null
    sleep 2
    pkill -9 -f MMSSTV.EXE 2>/dev/null
    echo "✅ MMSSTV 停止完了"
else
    echo "⚠️  MMSSTV 起動していない"
fi

# Hamlog停止
if pgrep -f Hamlogw.exe > /dev/null; then
    pkill -f Hamlogw.exe 2>/dev/null
    sleep 2
    echo "✅ Hamlog 停止完了"
else
    echo "⚠️  Hamlog 起動していない"
fi

# MailQSL停止
if pgrep -f MailQSL.exe > /dev/null; then
    pkill -f MailQSL.exe 2>/dev/null
    sleep 2
    echo "✅ MailQSL 停止完了"
else
    echo "⚠️  MailQSL 起動していない"
fi

echo "=== MMSSTV停止完了 ==="

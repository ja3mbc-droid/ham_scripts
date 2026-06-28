#!/bin/bash
echo "=== HAMLOG停止 ==="
ps aux | grep -w "Hamlogw.exe" | grep -v grep | awk '{print $2}' | xargs -r kill -9
echo "✅ Hamlog停止完了"

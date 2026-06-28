#!/bin/bash
echo "=== WSJT-X停止 ==="
pkill -TERM -f wsjtx 2>/dev/null && echo "✅ WSJT-X 停止" || echo "⚠️  WSJT-X 起動していない"
sleep 2
pkill -TERM -x rigctld 2>/dev/null && echo "✅ rigctld 停止" || echo "⚠️  rigctld 起動していない"
echo "=== WSJT-X停止完了 ==="

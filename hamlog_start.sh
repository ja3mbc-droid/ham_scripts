#!/bin/bash
echo "=== HAMLOG起動 ==="
if ! pgrep -f Hamlogw.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/Hamlogw.exe &
    echo "✅ Hamlog 起動完了"
else
    echo "⚠️  Hamlog 起動済み"
fi

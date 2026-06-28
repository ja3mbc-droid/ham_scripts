#!/bin/bash
# RM7400が起動中なら停止
if pgrep -f Remote7400 > /dev/null; then
    echo "⚠️  RM7400停止中..."
    pkill -f Remote7400 2>/dev/null
    sleep 2
    echo "✅ RM7400停止完了"
fi

# rigctld起動
if ! pgrep -x rigctld > /dev/null; then
    rigctld -m 3060 -r /dev/ttyUSB0 -s 9600 \
            -C data_bits=8 \
            -C stop_bits=1 \
            -C serial_handshake=None &
    echo "✅ rigctld 起動完了"
    sleep 3
fi

# WSJT-X ダークテーマで起動
if ! pgrep -x wsjtx > /dev/null; then
    QT_QPA_PLATFORMTHEME=gtk2 GTK_THEME=Adwaita:dark wsjtx &
    echo "✅ WSJT-X 起動完了"
else
    echo "⚠️  WSJT-X 起動済み"
fi

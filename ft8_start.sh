#!/bin/bash
echo "=== FT8モード起動 ==="
if pgrep -f Remote7400 > /dev/null; then
    echo "⚠️  RM7400停止中..."
    pkill -f Remote7400 2>/dev/null
    sleep 2
    echo "✅ RM7400停止完了"
fi
if ! pgrep -x flrig > /dev/null; then
    flrig &
    echo "✅ flrig 起動完了"
    sleep 3
fi
if ! pgrep -x rigctld > /dev/null; then
    rigctld -m 4 -t 4532 &
    echo "✅ rigctld 起動完了"
    sleep 2
fi
if ! pgrep -x wsjtx > /dev/null; then
    QT_QPA_PLATFORMTHEME=gtk2 GTK_THEME=Adwaita:dark wsjtx &
    echo "✅ WSJT-X 起動完了"
    sleep 5
else
    echo "⚠️  WSJT-X 起動済み"
fi
if ! pgrep -f Hamlogw.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/Hamlogw.exe &
    echo "✅ Hamlog 起動完了"
    sleep 3
else
    echo "⚠️  Hamlog 起動済み"
fi
if ! pgrep -f MailQSL.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/MailQSL.exe &
    echo "✅ MailQSL 起動完了"
else
    echo "⚠️  MailQSL 起動済み"
fi
if ! pgrep -f JT_Linker_2023.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/JT_Linker/JT_Linker_2023.exe &
    echo "✅ JT_Linker 起動完了"
    sleep 3
else
    echo "⚠️  JT_Linker 起動済み"
fi
echo "=== FT8モード 起動完了 ==="

#!/bin/bash
echo "fldigiモード起動中..."

# flrig起動
if ! pgrep flrig > /dev/null; then
    flrig &
    sleep 5
    echo "✅ flrig起動完了"
else
    echo "⚠️  flrig起動済み"
fi

# オーディオデバイスをC-Media USBに設定
pactl set-default-source alsa_input.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00.analog-mono
pactl set-default-sink alsa_output.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00.analog-stereo-output
echo "✅ オーディオデバイス設定完了"

# fldigi起動
fldigi &
echo "✅ fldigi起動完了"

# Hamlog起動
if ! pgrep -f Hamlogw.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/Hamlogw.exe &
    echo "✅ Hamlog起動完了"
    sleep 3
else
    echo "⚠️  Hamlog起動済み"
fi

# MailQSL起動
if ! pgrep -f MailQSL.exe > /dev/null; then
    WINEPREFIX=~/.wine wine ~/.wine/drive_c/Hamlog/MailQSL.exe &
    echo "✅ MailQSL起動完了"
else
    echo "⚠️  MailQSL起動済み"
fi

echo "=== fldigiモード 起動完了 ==="

#!/bin/bash
# FreeDV オーディオデバイス名を自動修正

# ラジオ受信入力 (C-Media USB mono)
RADIO_IN=$(pactl list sources short | grep "usb-C-Media.*analog-mono" | awk '{print $2}' | head -1)

# ラジオ送信出力 (C-Media USB stereo-output)
RADIO_OUT=$(pactl list sinks short | grep "usb-C-Media.*analog-stereo-output" | awk '{print $2}' | head -1)

# 内蔵マイク
MIC=$(pactl list sources short | grep "pci-0000_00_1b.0.analog-stereo" | grep -v monitor | awk '{print $2}' | head -1)

# 内蔵スピーカー
SPEAKER=$(pactl list sinks short | grep "pci-0000_00_1b.0.analog-stereo" | awk '{print $2}' | head -1)

echo "RADIO_IN  : $RADIO_IN"
echo "RADIO_OUT : $RADIO_OUT"
echo "MIC       : $MIC"
echo "SPEAKER   : $SPEAKER"

[ -n "$RADIO_IN" ]  && sed -i "s|soundCard1InDeviceName=.*|soundCard1InDeviceName=$RADIO_IN|"   ~/.freedv
[ -n "$RADIO_OUT" ] && sed -i "s|soundCard1OutDeviceName=.*|soundCard1OutDeviceName=$RADIO_OUT|" ~/.freedv
[ -n "$MIC" ]       && sed -i "s|soundCard2InDeviceName=.*|soundCard2InDeviceName=$MIC|"         ~/.freedv
[ -n "$SPEAKER" ]   && sed -i "s|soundCard2OutDeviceName=.*|soundCard2OutDeviceName=$SPEAKER|"   ~/.freedv

echo "✅ ~/.freedv オーディオ設定更新完了"

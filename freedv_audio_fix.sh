#!/bin/bash
# 内蔵マイクのデバイス名を自動検出して~/.freedvを更新
MIC=$(pactl list sources short | grep "pci-0000_00_1b.0.analog-stereo" | awk '{print $2}')
if [ -n "$MIC" ]; then
    sed -i "s|soundCard2InDeviceName=.*|soundCard2InDeviceName=$MIC|" ~/.freedv
    echo "マイクデバイス更新: $MIC"
fi

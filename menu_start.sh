#!/bin/bash
echo "================================"
echo "  JA3MBC HAM局 起動/停止メニュー"
echo "================================"
echo "--- 起動 ---"
echo "1) FT8モード"
echo "2) RM7400モード"
echo "3) WSJT-X単独"
echo "4) MMSSTV"
echo "5) RM7400+Hamlog+MailQSL"
echo "6) FreeDV"
echo "--- 停止 ---"

echo "7) FT8モード停止"
echo "8) RM7400モード停止"
echo "9) WSJT-X停止"
echo "10) MMSSTV停止"
echo "11) Hamlogモード停止"
echo "12) FreeDV停止"
echo "0) 終了"
echo "================================"
read -p "番号を選択してください: " choice
case $choice in
    1) ~/ft8_start.sh ;;
    2) ~/rm7400_start.sh ;;
    3) ~/wsjtx_start.sh ;;
    4) ~/mmsstv_start.sh ;;
    5) ~/hamlog_start.sh ;;
    6) ~/freedv_start.sh ;;
    7) ~/ft8_stop.sh ;;
    8) ~/rm7400_stop.sh ;;
    9) ~/wsjtx_stop.sh ;;
    10) ~/mmsstv_stop.sh ;;
    11) ~/hamlog_stop.sh ;;
    12) ~/freedv_stop.sh ;;
    0) echo "終了します" ; exit 0 ;;
    *) echo "無効な選択です" ;;
esac

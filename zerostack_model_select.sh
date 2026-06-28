#!/bin/bash
CONFIG="$HOME/.config/zerostack/config.json"
API_KEY="${OPENROUTER_API_KEY}"

MODELS=(
  "qwen/qwen3-coder:free"
  "deepseek/deepseek-v4-flash:free"
  "openai/gpt-oss-120b:free"
  "openai/gpt-oss-20b:free"
  "qwen/qwen3-next-80b-a3b-instruct:free"
  "nvidia/nemotron-3-super-120b-a12b:free"
  "meta-llama/llama-3.3-70b-instruct:free"
  "google/gemma-4-31b-it:free"
)

echo "========================================"
echo " zerostack モデル自動選択"
echo "========================================"

if [ -z "$API_KEY" ]; then
  echo "❌ OPENROUTER_API_KEY が設定されていません"
  exit 1
fi

echo ""
echo "🔍 利用可能なモデルを検索中..."
echo ""

SELECTED=""

for MODEL in "${MODELS[@]}"; do
  printf "  テスト中: %-45s ... " "$MODEL"

  RESPONSE=$(curl -s -o /tmp/zs_test.json -w "%{http_code}" \
    https://openrouter.ai/api/v1/chat/completions \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
      \"model\": \"$MODEL\",
      \"max_tokens\": 16,
      \"messages\": [{\"role\": \"user\", \"content\": \"hi\"}]
    }" 2>/dev/null)

  if [ "$RESPONSE" = "200" ]; then
    echo "✅ OK"
    SELECTED="$MODEL"
    break
  elif [ "$RESPONSE" = "429" ]; then
    echo "⏳ レート制限中"
  elif [ "$RESPONSE" = "402" ]; then
    echo "💳 クレジット不足"
  else
    echo "❌ エラー ($RESPONSE)"
  fi
done

echo ""

if [ -z "$SELECTED" ]; then
  echo "❌ 利用可能なモデルが見つかりませんでした"
  exit 1
fi

echo "✅ 選択されたモデル: $SELECTED"


# config.json に書き込む
mkdir -p "$(dirname "$CONFIG")"
cat > "$CONFIG" <<JSONEOF
{
  "provider": "openrouter",
  "model": "$SELECTED"
}
JSONEOF
echo "📝 config.json を更新しました"

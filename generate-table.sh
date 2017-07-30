#!bash
repo="vic/asdf-alpine"
gh="https://github.com/$repo"

echo '| Status | Source | Dockerfile |'
echo '|--------|--------|--------|'
for i in $(curl  https://api.github.com/repos/$repo/branches 2>/dev/null | jq -r .[].name); do
  echo -n "| [![Travis branch](https://img.shields.io/travis/$repo/$i.svg)]($gh/tree/$i)"
  echo -n "| [$i]($gh/tree/$i)"
  echo -n "| [\`FROM vborja/alpine:$i\`]($gh/blob/$i/Dockerfile) "
  echo '|'
done

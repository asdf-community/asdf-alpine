#!bash

name="asdf-alpine"
repo="vborja/$name"

gh_repo="vic/$name"
gh="https://github.com/$gh_repo"

function generate() {
echo '| Status | Dockerfile |'
echo '|--------|------------|'
for i in $(curl  https://api.github.com/repos/$gh_repo/branches 2>/dev/null | jq -r .[].name); do
  echo -n "| [![Travis branch](https://img.shields.io/travis/$gh_repo/$i.svg)](https://travis-ci.org/$gh_repo/branches#$i)"
  echo -n "| [\`FROM $repo:$i\`]($gh/blob/$i/Dockerfile) "
  echo '|'
done
}

ruby <<EOF
table = """
[_]: #begin-table

$(generate)

[_]: #end-table
"""

readme = File.read("README.md")
readme = readme.gsub(/\[_\]: #begin-table(.*)#end-table/m, table)
File.write("README.md", readme)
EOF




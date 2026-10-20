#!/bin/bash
set -euo pipefail

DATA_DIR=${NEWSBOT_DATA_DIR:-/data}
SOURCE_REF=${NEWSBOT_CONFIG_REF:-main}
BASE_URL="https://raw.githubusercontent.com/ansible-community/newsbot/${SOURCE_REF}"

echo "Updating newsbot config and template from ${SOURCE_REF} into ${DATA_DIR}."
mkdir -p "$DATA_DIR"
stage=$(mktemp -d "$DATA_DIR/.newsbot-update.XXXXXX")
trap 'rm -rf -- "$stage"' EXIT
echo "Staging downloads in ${stage}."

for filename in config.toml template.md; do
    echo "Downloading ${BASE_URL}/${filename}."
    curl --fail --silent --show-error --location \
        --retry 3 --retry-all-errors --retry-delay 2 \
        --connect-timeout 10 --max-time 60 \
        --output "$stage/$filename" "$BASE_URL/$filename"
    if [[ ! -s "$stage/$filename" ]]; then
        echo "Downloaded $filename is empty; leaving deployed files unchanged." >&2
        exit 1
    fi
    echo "Downloaded and staged ${filename}."
done

echo "Both downloads are ready; setting file permissions."
chmod 0644 "$stage/config.toml" "$stage/template.md"
echo "Moving staged config.toml to ${DATA_DIR}/config.toml."
mv -f -- "$stage/config.toml" "$DATA_DIR/config.toml"
echo "Moving staged template.md to ${DATA_DIR}/template.md."
mv -f -- "$stage/template.md" "$DATA_DIR/template.md"
echo "Newsbot config and template updated from ${SOURCE_REF}."

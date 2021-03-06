#!/bin/bash

if [[ $# -ne 6 ]]
then
    echo "Usage: $0 name slug rarity affinity type faction-slug"
    exit 1
fi

champion_file="$GOPATH/src/github.com/raid-codex/data/docs/champions/current/$2.json"
echo "{\"name\": \"$1\", \"slug\": \"$2\", \"rarity\": \"$3\", \"type\": \"$5\", \"faction_slug\": \"$6\", \"element\": \"$4\"}" > $champion_file

raid-codex-cli champions sanitize --champion-file $champion_file --data-directory $GOPATH/src/github.com/raid-codex/data
bash $GOPATH/src/github.com/raid-codex/data/scripts/rebuild_index.sh champions
raid-codex-cli scrap ayumilove champions --data-directory $GOPATH/src/github.com/raid-codex/data --champion-slug "$2" --with-stats
bash $GOPATH/src/github.com/raid-codex/data/scripts/rebuild_index.sh champions
raid-codex-cli scrap ayumilove champions --data-directory $GOPATH/src/github.com/raid-codex/data --champion-slug "$2" --with-builds
bash $GOPATH/src/github.com/raid-codex/data/scripts/rebuild_index.sh champions
raid-codex-cli scrap ayumilove champions --data-directory $GOPATH/src/github.com/raid-codex/data --champion-slug "$2" --with-masteries
bash $GOPATH/src/github.com/raid-codex/data/scripts/rebuild_index.sh champions
raid-codex-cli scrap ayumilove champions --data-directory $GOPATH/src/github.com/raid-codex/data --champion-slug "$2" --with-skills
bash $GOPATH/src/github.com/raid-codex/data/scripts/rebuild_index.sh champions

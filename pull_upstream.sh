#!/bin/bash
# pull_upstream.sh
# Récupère les corrections du prof pour TP 2025 et merge dans ta branche locale

echo "Fetching updates from upstream..."
git fetch upstream

echo "Merging upstream/2025/master into current branch..."
git merge upstream/2025/master

echo "Done. Your branch is now up-to-date with upstream/2025/master."

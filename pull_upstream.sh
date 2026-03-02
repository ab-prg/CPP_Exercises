#!/bin/bash
# pull_upstream.sh
# Met à jour ta branche étudiant 2025-master depuis le repo du prof

BRANCH_STUDENT="2025-master"
BRANCH_UPSTREAM="2025/master"

echo "=== Checking current branch ==="
CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" != "$BRANCH_STUDENT" ]; then
    echo "You are on '$CURRENT_BRANCH'."
    echo "Switching to $BRANCH_STUDENT..."
    git checkout $BRANCH_STUDENT || exit 1
fi

echo "=== Fetching updates from upstream ==="
git fetch upstream

echo "=== Merging upstream/$BRANCH_UPSTREAM into $BRANCH_STUDENT ==="
git merge upstream/$BRANCH_UPSTREAM

if [ $? -ne 0 ]; then
    echo ""
    echo "⚠️ Merge conflicts detected."
    echo "Resolve them, then run:"
    echo "  git add ."
    echo "  git commit"
    exit 1
fi

echo ""
echo "✅ Your branch is now up-to-date with upstream/$BRANCH_UPSTREAM."
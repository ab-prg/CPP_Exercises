#!/bin/bash
BRANCH_STUDENT="2025-master"
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH_STUDENT" ]; then
    git checkout $BRANCH_STUDENT || exit 1
fi
git status
git add .
if git diff-index --quiet HEAD --; then
    echo "No changes to commit."
else
    read -p "Enter commit message: " msg
    git commit -m "$msg"
fi
git push -u origin $BRANCH_STUDENT

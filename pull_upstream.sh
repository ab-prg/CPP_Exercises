#!/bin/bash
BRANCH_STUDENT="2025-master"
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH_STUDENT" ]; then
    git checkout $BRANCH_STUDENT || exit 1
fi
git pull origin $BRANCH_STUDENT

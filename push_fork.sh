#!/bin/bash
# push_fork.sh
# Push ton travail sur ton fork GitHub (safe étudiant)

BRANCH_STUDENT="2025-master"

# Vérifie la branche
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH_STUDENT" ]; then
    echo "⚠️ You are on '$CURRENT_BRANCH'."
    echo "Switching to $BRANCH_STUDENT..."
    git checkout $BRANCH_STUDENT || exit 1
fi

# Ajouter les fichiers modifiés
git add .

# Vérifie si des changements à commit
if git diff-index --quiet HEAD --; then
    echo "✅ No changes to commit."
else
    # Commit avec message
    read -p "Enter commit message: " msg
    git commit -m "$msg"
fi

# Push sur le fork (origin)
git push -u origin $BRANCH_STUDENT

echo "✅ Your changes have been pushed to your fork on branch $BRANCH_STUDENT!"
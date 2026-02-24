#!/bin/bash
# push_fork.sh
# Push ton travail sur ton fork GitHub

echo "Adding all changes..."
git add .

echo "Committing..."
read -p "Enter commit message: " msg
git commit -m "$msg"

echo "Pushing to origin..."
git push

echo "Done. Your changes are on your fork!"

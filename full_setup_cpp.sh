#!/bin/bash

### ========= CONFIG ========= ###
GITHUB_USER="ab-prg"           # ton pseudo GitHub
REPO_NAME="CPP_Exercises"
BRANCH_STUDENT="2025-master"
FORK_SSH="git@github.com:ab-prg/CPP_Exercises.git"
### =========================== ###

# --- Git installation ---
echo "=== Checking Git installation ==="
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

# --- Git identity ---
echo "=== Configuring Git identity ==="
CURRENT_NAME=$(git config --global user.name)
CURRENT_EMAIL=$(git config --global user.email)

if [ -z "$CURRENT_NAME" ]; then
    read -p "Git user.name is missing. Enter your GitHub username: " GITHUB_USER
    git config --global user.name "$GITHUB_USER"
else
    echo "Git user.name is already set to '$CURRENT_NAME'"
fi

if [ -z "$CURRENT_EMAIL" ]; then
    read -p "Git user.email is missing. Enter your GitHub email (optional, press enter to skip): " GITHUB_EMAIL
    if [ -n "$GITHUB_EMAIL" ]; then
        git config --global user.email "$GITHUB_EMAIL"
    fi
else
    echo "Git user.email is already set to '$CURRENT_EMAIL'"
fi

# --- SSH key ---
echo "=== Checking SSH key ==="
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "No SSH key found. Creating one..."
    read -p "Enter your GitHub email for SSH key (optional, press enter to skip): " SSH_EMAIL
    ssh-keygen -t ed25519 -C "$SSH_EMAIL"
fi

echo "=== Starting SSH agent ==="
eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null

echo "=== Testing GitHub SSH connection ==="
ssh -T git@github.com

# --- Clone repo ---
echo "=== Cloning your fork ==="
git clone $FORK_SSH
cd $REPO_NAME || exit

echo "=== Checking out your student branch ==="
git checkout $BRANCH_STUDENT || git checkout -b $BRANCH_STUDENT

# --- Git aliases ---
echo "=== Setting useful Git aliases ==="
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch

# --- Create pull/push scripts ---
echo "=== Creating pull/push scripts ==="

cat << 'EOF' > pull_upstream.sh
#!/bin/bash
BRANCH_STUDENT="2025-master"
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH_STUDENT" ]; then
    git checkout $BRANCH_STUDENT || exit 1
fi
git pull origin $BRANCH_STUDENT
EOF
chmod +x pull_upstream.sh

cat << 'EOF' > push_fork.sh
#!/bin/bash
BRANCH_STUDENT="2025-master"
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH_STUDENT" ]; then
    git checkout $BRANCH_STUDENT || exit 1
fi
git add .
if git diff-index --quiet HEAD --; then
    echo "No changes to commit."
else
    read -p "Enter commit message: " msg
    git commit -m "$msg"
fi
git push -u origin $BRANCH_STUDENT
EOF
chmod +x push_fork.sh

echo "=== Setup complete ==="
echo "Work branch      : $BRANCH_STUDENT"
echo "You can now use ./pull_upstream.sh and ./push_fork.sh safely!"
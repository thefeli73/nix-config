#!/usr/bin/env bash
# Symlink agent skills and commands from this git repo to global config
set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
SOURCE_SKILLS_DIR="$REPO_ROOT/.agents/skills"
SOURCE_AGENTS_FILE="$REPO_ROOT/AGENTS.md"
SOURCE_COMMANDS_DIR="$REPO_ROOT/.opencode/commands"

# Sync the repo first
echo "Syncing git repository..."
cd "$REPO_ROOT"
git fetch
git pull --ff-only || {
    echo "Warning: Could not fast-forward pull. You may have local changes."
    echo "Continuing with current state..."
}
TARGET_DIR="$HOME/.agents"
TARGET_SKILLS_LINK="$TARGET_DIR/skills"
TARGET_AGENTS_LINK="$TARGET_DIR/AGENTS.md"
TARGET_CONFIG_DIR="$HOME/.config/opencode"
TARGET_COMMANDS_LINK="$TARGET_CONFIG_DIR/commands"

# Verify sources exist
if [ ! -d "$SOURCE_SKILLS_DIR" ]; then
    echo "Error: Source directory not found: $SOURCE_SKILLS_DIR"
    echo "Make sure you're running this from within the git repo."
    exit 1
fi
if [ ! -f "$SOURCE_AGENTS_FILE" ]; then
    echo "Error: Source file not found: $SOURCE_AGENTS_FILE"
    echo "Make sure you're running this from within the git repo."
    exit 1
fi
if [ ! -d "$SOURCE_COMMANDS_DIR" ]; then
    echo "Error: Source directory not found: $SOURCE_COMMANDS_DIR"
    echo "Create .opencode/commands/ in this repo and add your command files."
    exit 1
fi

# Create target directory
mkdir -p "$TARGET_DIR"
mkdir -p "$TARGET_CONFIG_DIR"

# Handle existing skills target
if [ -L "$TARGET_SKILLS_LINK" ]; then
    CURRENT_TARGET=$(readlink "$TARGET_SKILLS_LINK")
    if [ "$CURRENT_TARGET" = "$SOURCE_SKILLS_DIR" ]; then
        echo "Skills symlink already exists and points to correct location."
        echo "  $TARGET_SKILLS_LINK -> $SOURCE_SKILLS_DIR"
    else
        echo "Updating existing skills symlink..."
        echo "  Old: $TARGET_SKILLS_LINK -> $CURRENT_TARGET"
        rm "$TARGET_SKILLS_LINK"
        ln -s "$SOURCE_SKILLS_DIR" "$TARGET_SKILLS_LINK"
    fi
elif [ -d "$TARGET_SKILLS_LINK" ]; then
    echo "Error: $TARGET_SKILLS_LINK is a directory, not a symlink."
    echo "Please manually merge or remove it first:"
    echo "  rm -rf $TARGET_SKILLS_LINK"
    exit 1
elif [ -e "$TARGET_SKILLS_LINK" ]; then
    echo "Error: $TARGET_SKILLS_LINK exists but is not a symlink or directory."
    exit 1
else
    ln -s "$SOURCE_SKILLS_DIR" "$TARGET_SKILLS_LINK"
fi

# Handle existing AGENTS.md target
if [ -L "$TARGET_AGENTS_LINK" ]; then
    CURRENT_TARGET=$(readlink "$TARGET_AGENTS_LINK")
    if [ "$CURRENT_TARGET" = "$SOURCE_AGENTS_FILE" ]; then
        echo "AGENTS.md symlink already exists and points to correct location."
        echo "  $TARGET_AGENTS_LINK -> $SOURCE_AGENTS_FILE"
    else
        echo "Updating existing AGENTS.md symlink..."
        echo "  Old: $TARGET_AGENTS_LINK -> $CURRENT_TARGET"
        rm "$TARGET_AGENTS_LINK"
        ln -s "$SOURCE_AGENTS_FILE" "$TARGET_AGENTS_LINK"
    fi
elif [ -e "$TARGET_AGENTS_LINK" ]; then
    echo "Error: $TARGET_AGENTS_LINK exists and is not a symlink."
    echo "Please manually merge or remove it first."
    exit 1
else
    ln -s "$SOURCE_AGENTS_FILE" "$TARGET_AGENTS_LINK"
fi

# Handle existing commands target
if [ -L "$TARGET_COMMANDS_LINK" ]; then
    CURRENT_TARGET=$(readlink "$TARGET_COMMANDS_LINK")
    if [ "$CURRENT_TARGET" = "$SOURCE_COMMANDS_DIR" ]; then
        echo "Commands symlink already exists and points to correct location."
        echo "  $TARGET_COMMANDS_LINK -> $SOURCE_COMMANDS_DIR"
    else
        echo "Updating existing commands symlink..."
        echo "  Old: $TARGET_COMMANDS_LINK -> $CURRENT_TARGET"
        rm "$TARGET_COMMANDS_LINK"
        ln -s "$SOURCE_COMMANDS_DIR" "$TARGET_COMMANDS_LINK"
    fi
elif [ -d "$TARGET_COMMANDS_LINK" ]; then
    echo "Error: $TARGET_COMMANDS_LINK is a directory, not a symlink."
    echo "Please manually move files into repo commands and remove it first:"
    echo "  mkdir -p $SOURCE_COMMANDS_DIR"
    echo "  cp -R $TARGET_COMMANDS_LINK/. $SOURCE_COMMANDS_DIR/"
    echo "  rm -rf $TARGET_COMMANDS_LINK"
    exit 1
elif [ -e "$TARGET_COMMANDS_LINK" ]; then
    echo "Error: $TARGET_COMMANDS_LINK exists but is not a symlink or directory."
    exit 1
else
    ln -s "$SOURCE_COMMANDS_DIR" "$TARGET_COMMANDS_LINK"
fi

echo "Symlinked successfully!"
echo "  $TARGET_SKILLS_LINK -> $SOURCE_SKILLS_DIR"
echo "  $TARGET_AGENTS_LINK -> $SOURCE_AGENTS_FILE"
echo "  $TARGET_COMMANDS_LINK -> $SOURCE_COMMANDS_DIR"
echo ""
echo "Global skills now available:"
ls "$TARGET_SKILLS_LINK" | sed 's/^/  - /'

echo ""
echo "Global AGENTS.md now available:"
ls -la "$TARGET_AGENTS_LINK"

echo ""
echo "Global commands now available:"
ls "$TARGET_COMMANDS_LINK" | sed 's/^/  - /'

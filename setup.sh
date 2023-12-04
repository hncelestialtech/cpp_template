# Check if pip3 is installed
if which pip3 >/dev/null; then
    echo "[1]\tpip3 is installed"
    # Check if clang-format is installed
    if pip3 list | grep clang-format >/dev/null; then
        echo "[2]\tclang-format is already installed"
    else
        echo "[2]\tInstalling clang-format..."
        pip3 install clang-format
        echo "\tclang-format installed successfully"
    fi

    echo "#!/bin/bash\n
# Run clang-format on all staged changes\n
git diff --cached --name-only --diff-filter=ACM | grep -E '\.(c|h|cpp|hpp|cc)$' | xargs clang-format -i\n

# Add the changes back to the commit\n
git add .\n

# Continue with the commit\n
exit 0\n" 1> .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "[3]\tpre-commit hook installed successfully"

else
    echo "pip3 is not installed, exit with failure."
fi

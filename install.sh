#!/bin/bash
set -e

echo "Installing shelltide..."

SHELLTIDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_PATH="$HOME/.shelltide/venv"

mkdir -p "$HOME/.shelltide"

if [ ! -d "$VENV_PATH" ]; then
    python3 -m venv "$VENV_PATH"
fi

source "$VENV_PATH/bin/activate"
pip install --upgrade pip -q
pip install -r "$SHELLTIDE_DIR/requirements.txt" -q
deactivate

sudo tee /usr/local/bin/shelltide > /dev/null << SCRIPT
#!/bin/bash
"$HOME/.shelltide/venv/bin/python3" "$SHELLTIDE_DIR/shelltide.py" "\$@"
SCRIPT

sudo chmod +x /usr/local/bin/shelltide

echo ""
echo "Done! Try: shelltide --location \"Boston, MA\""

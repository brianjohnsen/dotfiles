#!/usr/bin/env bash
# Custom history configuration
# https://www.thomaslaurenson.com/blog/2018/07/02/better-bash-history/
# https://gist.github.com/thomaslaurenson/ae72d4b4ec683f5a1850d42338a9a4ab
#
# Run script using:
# chmod u+x better_history.sh
# sudo su
# ./better_history.sh

set -euo pipefail

GLOBALBASHRC=/etc/bash.bashrc
MARKER="# >>> better_history >>>"

echo ">>> Starting"

# Idempotent: bail out if the config block is already present
if grep -qF "$MARKER" "$GLOBALBASHRC"; then
    echo ">>> better_history already configured in $GLOBALBASHRC - nothing to do"
    exit 0
fi

# Back up the original once - don't clobber an existing backup
if [ ! -f /etc/bash.bashrc.old ]; then
    echo ">>> Copying original $GLOBALBASHRC to /etc/bash.bashrc.old"
    cp "$GLOBALBASHRC" /etc/bash.bashrc.old
fi

echo ">>> Loading configuration into $GLOBALBASHRC"
cat >> "$GLOBALBASHRC" <<'EOF'

# >>> better_history >>>
HISTTIMEFORMAT='%F %T '
HISTFILESIZE=-1
HISTSIZE=-1
HISTCONTROL=ignoredups
HISTIGNORE=?:??
# append to history, dont overwrite it
shopt -s histappend
# attempt to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# save multi-line commands to the history with embedded newlines
shopt -s lithist
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# <<< better_history <<<
EOF

echo ">>> Finished. Open a new shell for the settings to take effect."

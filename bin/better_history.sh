#!/usr/bin/env bash
# Custom history configuration
# https://www.thomaslaurenson.com/blog/2018/07/02/better-bash-history/
# https://gist.github.com/thomaslaurenson/ae72d4b4ec683f5a1850d42338a9a4ab
#
# Run script using:
# chmod u+x better_history.sh
# sudo su
# ./better_history.sh

GLOBALBASHRC=/etc/bash.bashrc

echo ">>> Starting"
echo ">>> Copying original $GLOBALBASHRC"
cp $GLOBALBASHRC /etc/bash.bashrc.old
echo ">>> Loading configuration into $GLOBALBASHRC"
echo "HISTTIMEFORMAT='%F %T '" >> $GLOBALBASHRC
echo 'HISTFILESIZE=-1' >> $GLOBALBASHRC
echo 'HISTSIZE=-1' >> $GLOBALBASHRC
echo 'HISTCONTROL=ignoredups' >> $GLOBALBASHRC
echo 'HISTIGNORE=?:??' >> $GLOBALBASHRC
echo '# append to history, dont overwrite it' >> $GLOBALBASHRC
echo 'shopt -s histappend' >> $GLOBALBASHRC
echo '# attempt to save all lines of a multiple-line command in the same history entry' >> $GLOBALBASHRC
echo 'shopt -s cmdhist' >> $GLOBALBASHRC
echo '# save multi-line commands to the history with embedded newlines' >> $GLOBALBASHRC
echo 'shopt -s lithist' >> $GLOBALBASHRC
echo '# After each command, append to the history file and reread it' >> $GLOBALBASHRC
echo 'export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"' >> $GLOBALBASHRC

# Reload BASH for settings to take effect
echo ">>> Reloading BASH"
exec "$BASH"

echo ">>> Finished. Exiting."
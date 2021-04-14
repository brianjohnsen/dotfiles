#@IgnoreInspection BashAddShebang

## COPY
# cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/¡

## Navigation
alias kkk='cd ~/PROJEKTER/ERST/kompensationsmodul'
alias fp='cd ~/PROJEKTER/GTIT/formueportalen && export GRAILS_OPTS="-Xmx2G -Xms512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"'
alias formueportalen='fp'

## System
alias updateAll='LANG=C sudo apt -y update && LANG=C sudo apt -y upgrade && LANG=C sudo apt -y autoremove'

## ERST
alias erstMountLogs='cd ~/.dotfiles/bin && bash ./erst_create_logs_mount.sh && cd /media/nc/logs-nine/kompensationsmodul/'
alias erstCopyProdLogs='cd /media/nc/logs-nine/kompensationsmodul && cat prod-app-p06/kompensationsmodul.log prod-app-p05/kompensationsmodul.log > /tmp/KOMP.log && cd /tmp'
alias erstCopyDevLogs='cd /media/nc/logs-nine/kompensationsmodul && cat dev-app-d06/kompensationsmodul.log dev-app-d05/kompensationsmodul.log > /tmp/KOMPDEV.log && cd /tmp'
alias erstCopyTestLogs='cd /media/nc/logs-nine/kompensationsmodul && cat test-app-t06/kompensationsmodul.log test-app-t05/kompensationsmodul.log > /tmp/KOMPTEST.log && cd /tmp'
alias erstVpn='cd ~/.dotfiles/bin && bash ./anyconnect-vpn.sh'

## General
alias ll='ls -lah'

## Gradle
alias gw='./gradlew'
alias gwc='./gradlew clean'
alias gwb='./gradlew bootRun'
alias gwcb='./gradlew clean bootRun'
alias gwgeb='./gradlew clean iT --tests "*geb*" -Dgrails.test.ignoreGebTest=false'
alias gwcc='./gradlew clean check ; alert'
alias gwccc='./gradlew clean check -DENABLE_CLOVER=true; alert'
alias gwct='./gradlew clean test integrationTest ; alert'
alias gwcodenarc='./gradlew codenarcMain codenarcTest codenarcIntegrationTest'

## GRAILS
alias gt='grails test'
alias gta='grails test-app -echoOut'
alias grun='grails run-app'
alias gcta='clear && grails clean-all && grails compile && grails test-app'
#alias opentests='open target/test-reports/html/index.html'

# Dell specific
alias dellServiceTag='sudo dmidecode -s system-serial-number'
alias dellModelNumber='sudo dmidecode -s system-product-name'

## Bash-It
alias copyBashItCustom='cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/ && cp -v ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/ && source ~/.bashrc'

## Open reports
alias opentestreport='xdg-open build/reports/tests/index.html &> /dev/null'
alias opencobertura='xdg-open build/reports/cobertura/index.html &> /dev/null'

alias runcheck='runCodenarcCleanCheckExitIfFailure'
alias runtest='runCleanTest'

alias open='openFile'

## GIT
alias pull="git pull && git submodule update --init --recursive ; alert"
alias push="git push ; alert"
alias st="git st"
alias gl="git log"
alias gcm="git co master"
alias gc-="git co -"
alias gg="git graph"
alias gclonecd="gitCloneCd"
# https://stackoverflow.com/questions/2517339/how-to-recover-the-file-permissions-to-what-git-thinks-the-file-should-be
alias gitPermissionsReset='git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'
alias gitUndoLastCommit="git reset --soft HEAD~1"
alias gitResetCommitDate='git commit --amend --no-edit --date "$(date)"'
#GitAhead
alias ga="ga &> /dev/null &"
alias gitahead="ga &> /dev/null &"


# sublime text
alias s='subl'

# Nice path
alias path='echo -e ${PATH//:/\\n}'

# From: http://askubuntu.com/questions/409611/desktop-notification-when-long-running-commands-complete
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Wifi on/off
alias wd='nmcli radio wifi off'
alias wu='nmcli radio wifi on'
# Wifi network
alias wifijohnsen='nmcli c up johnsen'


########################################################################################################################
## From bash-it -> osx.aliases.bash
########################################################################################################################

# From http://apple.stackexchange.com/questions/110343/copy-last-command-in-terminal
#alias copyLastCmd='fc -ln -1 | awk '\''{$1=$1}1'\'' ORS='\'''\'' | pbcopy'


########################################################################################################################
## UNALIAS
########################################################################################################################
unalias piano
unalias irc
unalias rb
unalias py
unalias ipy
unalias edit
unalias pager
#unalias pcurl
unalias pass
#unalias shuf
unalias vbrc
unalias vbpf


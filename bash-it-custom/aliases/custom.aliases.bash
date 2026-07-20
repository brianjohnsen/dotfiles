#@IgnoreInspection BashAddShebang


## Navigation
alias bfri='befri'
alias befri='cd ~/PROJEKTER/GTIT/befri'
alias fp='cd ~/PROJEKTER/GTIT/formueportalen && export GRAILS_OPTS="-Xmx2G -Xms512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"'
alias formueportalen='fp'

## System
alias updateAll='LANG=C sudo apt -y update && LANG=C sudo apt -y upgrade && LANG=C sudo apt -y autoremove'

## Backup / restore (see ~/.dotfiles/backup/README.md)
alias backup='bash ~/.dotfiles/backup/backup.sh'
alias restore='bash ~/.dotfiles/backup/restore.sh'

## General
alias ll='ls -lah'
alias open='openFile'

## Gradle
#alias gw='./gradlew'
alias gw='gradlewFromParents'
alias gwc='gw clean'
alias gwb='gw bootRun'
alias gwbc='gw bootRunWithClient'
alias gwclient='gw :client:serve'
alias gwserver='gw :server:bootRun'
alias gwserverLokalDb='gw :server:bootRun -Dgrails.env=pipeline'
alias gwccserver='gw :server:clean :server:check ; alert'
alias gwcb='gw clean bootRun'
alias gwcc='gw clean check ; alert'
alias gwccc='runCodenarcCleanCheckExitIfFailure'
alias gwct='gw clean test integrationTest ; alert'
alias gwcodenarc='gw codenarcMain codenarcTest codenarcIntegrationTest'

alias runcheck='runCodenarcCleanCheckExitIfFailure'
alias runtest='runCleanTest'


# Dell specific
alias dellServiceTag='sudo dmidecode -s system-serial-number'
alias dellModelNumber='sudo dmidecode -s system-product-name'

## Open reports
alias opentestreport='openTestReport'
#alias opencobertura='xdg-open build/reports/cobertura/index.html &> /dev/null'
alias openclover='open build/reports/clover/html/index.html'


## GIT
alias pull="git pull && git submodule update --init --recursive ; alert"
alias push="git push ; alert"
alias st="git st"
alias gl="git log"
alias gcm="git branch | grep -o -E ' master| main' | tr -d ' ' | xargs git switch"
alias gc-="git switch -"
alias gg="git graph"
# https://stackoverflow.com/questions/2517339/how-to-recover-the-file-permissions-to-what-git-thinks-the-file-should-be
alias gitPermissionsReset='git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'
alias gitUndoLastCommit="git reset --soft HEAD~1"
alias gitResetCommitDate='git commit --amend --no-edit --date "$(date)"'

alias dockerpurge='echo "Purging docker containers and images" && docker container prune -f && docker image prune -af'

# Nice path
alias path='echo -e ${PATH//:/\\n}'


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
#unalias piano
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

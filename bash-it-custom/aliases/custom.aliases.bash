#@IgnoreInspection BashAddShebang

## COPY
# cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/¡

## Navigation
alias kkk='cd ~/PROJEKTER/ERST/kompensationsmodul'

## Gradle
alias gw='./gradlew'
alias gwc='./gradlew clean'
alias gwb='./gradlew bootRun'
alias gwcb='./gradlew clean bootRun'
alias gwcc='./gradlew clean check ; alert'
alias gwct='./gradlew clean test integrationTest ; alert'
alias gwcodenarc='./gradlew codenarcMain codenarcTest codenarcIntegrationTest'
alias cleanPostgres='docker stop postgres && sudo rm -rf /tmp/postgres_data/ && docker start postgres'

## GRAILS
alias gt='sdk switch && grails -reloading test --non-interactive'
alias gta='sdk switch && grails test-app -echoOut --non-interactive'
alias grun='sdk switch && grails -reloading run-app --non-interactive'
alias gcta='sdk switch && clear && grails clean-all && grails compile && grails test-app'
#alias opentests='open target/test-reports/html/index.html'
alias formueportalenEnvironment='export GRAILS_OPTS="-Xmx2G -Xms512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8" && sdk use grails 2.2.4 && sdk use java 7.0.201-zulu'

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
alias gitResetPermissions='git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'
alias gitUndoLastCommit="git reset --soft HEAD~1"



## SKAT
alias skattunnel='ssh -N -L 127.0.0.1:7011:sktdemo01esb01:7011 -L 127.0.0.1:7013:sktdemo01esb01:7013 admin@sktdemo01jmp01.ccta.dk'
alias skatroutes='sudo ip route add 172.24.0.0/16 dev enx000ec6f9fd68 via 10.3.0.1  && sudo ip route add 172.23.0.0/16 dev enx000ec6f9fd68 via 10.3.0.1 && sudo ip route add 172.20.0.0/16 dev enx000ec6f9fd68 via 10.3.0.1'
alias skatdualnetwork='ccta'
#alias vpnup='nmcli con up id SKAT'
#alias vpndown='nmcli con down id SKAT'
alias vu='openVpn'
alias openVpn='cd ~/.dotfiles/bin && echo -e "\033]2;SKAT VPN\007" && ./activate-vpn.sh'

alias killfrontend='sudo kill $(sudo lsof -t -i:4200)'

alias killcitrixbox='sudo kill $(sudo lsof -t -i:2222)'
alias citrixbox='z citrix && vagrant up && vagrant ssh -- -X firefox -no-remote' #relies on fasd

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
alias wifikoncern_wifi='nmcli c up koncern-wifi'
alias wifi_kon_tst_app='nmcli c up kon_tst_app'



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


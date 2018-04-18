#@IgnoreInspection BashAddShebang

## COPY
# cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/¡

## Navigation
alias rente='cd ~/PROJEKTER/SKAT/RENTE/rente'
alias ren='rente'

## Gradle
alias gwcc='mountebank && ./gradlew clean check'
alias gwct='mountebank && ./gradlew clean test integrationTest'
alias gwcodenarc='./gradlew codenarcMain codenarcTest codenarcIntegrationTest'
alias gw='./gradlew'
alias cleanPostgres='docker stop postgres && sudo rm -rf /tmp/postgres_data/ && docker start postgres'

## GRAILS
alias gt='sdk switch && grails -reloading test --non-interactive'
alias gta='sdk switch && grails test-app -echoOut --non-interactive'
alias grun='sdk switch && grails -reloading run-app --non-interactive'
alias gcta='sdk switch && clear && grails clean-all && grails compile && grails test-app'
#alias opentests='open target/test-reports/html/index.html'

## JAVA
alias useJava8='yes | sudo apt-get install oracle-java8-set-default && source ~/.bashrc'
alias useJava7='yes | sudo apt-get install oracle-java7-set-default && source ~/.bashrc'

## Bash-It
alias copyBashItCustom='cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/ && cp -v ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/ && source ~/.bashrc'

## Open reports
alias opentestreport='xdg-open build/reports/tests/index.html &> /dev/null'
alias opencobertura='xdg-open build/reports/cobertura/index.html &> /dev/null'

alias runcheck='docker start mountebank && runCodenarcCleanCheckExitIfFailure'
alias runtest='docker start mountebank && runCleanTest'
alias mountebank='docker start mountebank'

alias open='openFile'

## GIT
alias pull="git pull && git submodule update --init --recursive ; alert"
alias push="git push ; alert"
alias st="git st"
alias gl="git log"
alias gcm="git co -"
alias gg="git graph"
alias gclonecd="gitCloneCd"

## SKAT
alias skattunnel='ssh -N -L 127.0.0.1:7011:sktdemo01esb01:7011 -L 127.0.0.1:7013:sktdemo01esb01:7013 admin@sktdemo01jmp01.ccta.dk'
alias skatdualnetwork='ccta'

alias citrixbox='z citrix && vagrant up && vagrant ssh -- -X firefox -no-remote' #relies on fasd

# sublime text
alias s='subl'

# Nice path
alias path='echo -e ${PATH//:/\\n}'

# From: http://askubuntu.com/questions/409611/desktop-notification-when-long-running-commands-complete
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


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


#@IgnoreInspection BashAddShebang

## COPY
# cp -v ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/

export GRAILS_OPTS="-Xmx2G -Xms512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"
#export GRAILS_OPTS="-Xmx2G -Xms512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"

#export LC_ALL=da_DK.UTF-8

## Removes (ugly!) clock char from bash-it theme
export THEME_SHOW_CLOCK_CHAR=false

# Fixes ugly dir color in gnome terminal
## See: https://askubuntu.com/questions/881949/ugly-color-for-directories-in-gnome-terminal
LS_COLORS=$LS_COLORS:'ow=1;34:tw=1;34:' ; export LS_COLORS


export HISTSIZE=10000
export HISEFILESIZE=10000


PROMPT_COMMAND='echo -en "\033]0; $(pwd) \a"'


## clones a git repo and cd into the folder
gitCloneCd() {
    PARAMS=$@
    A=${PARAMS%.*}
    B=${A##*/}

    git clone ${PARAMS} && cd "${B}"
}


openFile() {
    xdg-open $@ &> /dev/null
}


openSkatVpn() {
    url="webvpn.skat.dk"
    group="DevOPS-ext"
    echo -e '\033]2;SKAT VPN\007'
    copyq add $SKAT_PASSWORD #add to clipboard
    sudo openconnect --usergroup=$group --user=$SKAT_WNUMMER $url
}


## Enables dual network at SKAT (WiFi must be at the top!)
function ccta() {
    sudo route -n delete 192.168.146.0 10.3.0.1 -netmask 255.255.255.0
    sudo route -n delete 172.20.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n delete 172.23.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n delete 172.24.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n add 192.168.146.0 10.3.0.1 -netmask 255.255.255.0
    sudo route -n add 172.20.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n add 172.23.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n add 172.24.0.0 10.3.0.1 -netmask 255.255.0.0
}


##
# Run all codenarc rules.
# Opens the respective reports if they fail.
# Run all tests if codenarc is happy!
# Opens the test report if any test fail.
##
function runCodenarcCleanCheckExitIfFailure() {
    success=true
    ./gradlew clean
    if ! ./gradlew codenarcMain; then
        xdg-open build/reports/codenarc/main.html &> /dev/null
        success=false
    fi
    if ! ./gradlew codenarcTest; then
        xdg-open build/reports/codenarc/test.html &> /dev/null
        success=false
    fi
    if ! ./gradlew codenarcIntegrationTest; then
        xdg-open build/reports/codenarc/integrationTest.html &> /dev/null
        success=false
    fi
    # Exit if codenarc has failed
    if ! $success; then
        return 1
    fi
    notify-send 'Codenarc was successful'

    # If all is well run all tests
    if ! ./gradlew clean check; then
        xdg-open build/reports/tests/index.html &> /dev/null
        return 1
    else
        notify-send 'BUILD WAS SUCCESSFUL!'
    fi
}


function runCleanTest() {
    if ! ./gradlew clean test integrationTest; then
        xdg-open build/reports/tests/index.html &> /dev/null
        return 1
    else
        notify-send 'TEST WAS SUCCESSFUL!'
    fi
}

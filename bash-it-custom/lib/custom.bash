#@IgnoreInspection BashAddShebang


export GRAILS_OPTS="-Xmx4G -Xms512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"
#export GRAILS_OPTS="-Xmx4G -Xms512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"

#export LC_ALL=da_DK.UTF-8

# Fixes ugly dir color in gnome terminal
## See: https://askubuntu.com/questions/881949/ugly-color-for-directories-in-gnome-terminal
LS_COLORS=$LS_COLORS:'ow=1;34:tw=1;34:' ; export LS_COLORS



PATH=$PATH:~/.dotfiles/local-bin
# required by claude
PATH=$PATH:~/.local/bin


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


#openSkatVpn() {
#    url="webvpn.skat.dk"
#    group="DevOPS-ext"
#    echo -e '\033]2;SKAT VPN\007'
#    copyq add $SKAT_PASSWORD #add to clipboard
#    sudo openconnect --usergroup=$group --user=$SKAT_WNUMMER $url
#}


##
# Run all codenarc rules.
# Opens the respective reports if they fail.
# Run all tests if codenarc is happy!
# Opens the test report if any test fail.
##
function runCodenarcCleanCheckExitIfFailure() {
    success=true
    gradlewFromParents clean
    if ! gradlewFromParents codenarcMain; then
        xdg-open build/reports/codenarc/main.html &> /dev/null
        success=false
    fi
    if ! gradlewFromParents codenarcTest; then
        xdg-open build/reports/codenarc/test.html &> /dev/null
        success=false
    fi
    if ! gradlewFromParents codenarcIntegrationTest; then
        xdg-open build/reports/codenarc/integrationTest.html &> /dev/null
        success=false
    fi
    # Exit if codenarc has failed
    if ! $success; then
        return 1
    fi
    notify-send 'Codenarc was successful'

    # If all is well run all tests
    if ! gradlewFromParents clean check; then
        xdg-open build/reports/tests/index.html &> /dev/null
        return 1
    else
        notify-send 'BUILD WAS SUCCESSFUL!'
    fi
}

##
# Gets latest grails app from GRAILS APPLICATION FORGE and opens `build.gradle` and `gradle.properties`.
##
function getLatestGrailsAndOpen() {
    TMPDIR=/tmp/latestgrails
    rm -r $TMPDIR
    mkdir $TMPDIR
    curl https://start.grails.org/project.zip -d profile=rest-api -o $TMPDIR/project.zip
    unzip -qq $TMPDIR/project.zip -d $TMPDIR
    xdg-open $TMPDIR/project/build.gradle &> /dev/null
    xdg-open $TMPDIR/project/gradle.properties &> /dev/null
}


function runCleanTest() {
    if ! gradlewFromParents clean test integrationTest; then
        xdg-open build/reports/tests/index.html &> /dev/null
        return 1
    else
        notify-send 'TEST WAS SUCCESSFUL!'
    fi
}

##
# Opens the test report if it exists, searching subdirectories if needed
##
function openTestReport() {
    local report
    report=$(find . -path "*/build/reports/tests/index.html" 2>/dev/null | head -1)
    if [ -n "$report" ]; then
        echo "Opening integration test report..."
        xdg-open "$report" &> /dev/null
        return
    fi
    report=$(find . -path "*/build/reports/tests/test/index.html" 2>/dev/null | head -1)
    if [ -n "$report" ]; then
        echo "Opening unit test report..."
        xdg-open "$report" &> /dev/null
        return
    fi
    echo "No test report found"
}

# From: http://askubuntu.com/questions/409611/desktop-notification-when-long-running-commands-complete
# Use -u normal + -t; -u critical makes GNOME ignore the timeout.
function alert() {
    local exit_code=$?
    local cmd
    cmd=$(history | tail -n1 | sed -e 's/^\s*[0-9 -:]\+\s*//;s/[;&|]\s*alert$//')
    if [ $exit_code = 0 ]; then
        notify-send -u normal -i dialog-information -t 5000 "✓ Done" "$cmd"
    else
        notify-send -u normal -i dialog-error -t 10000 "✗ Failed" "$cmd"
    fi
}

##
# bashit gradle-plugin before this commit:  https://github.com/Bash-it/bash-it/commit/7ed12083f26ce95cb9018bf6688fdba2e96514dc
##
function gradlewFromParents() {
  local file="gradlew"
  local curr_path="${PWD}"
  local result="gradle"

  # Search recursively upwards for file.
  until [[ "${curr_path}" == "/" ]]; do
    if [[ -e "${curr_path}/${file}" ]]; then
      result="${curr_path}/${file}"
      break
    else
      curr_path=$(dirname "${curr_path}")
    fi
  done

  # Call gradle
  "${result}" $*
}

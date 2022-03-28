#@IgnoreInspection BashAddShebang

## COPY
# cp -v ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/

export GRAILS_OPTS="-Xmx4G -Xms512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"
#export GRAILS_OPTS="-Xmx4G -Xms512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"

#export LC_ALL=da_DK.UTF-8

## Removes (ugly!) clock char from bash-it theme
export THEME_SHOW_CLOCK_CHAR=false

# Fixes ugly dir color in gnome terminal
## See: https://askubuntu.com/questions/881949/ugly-color-for-directories-in-gnome-terminal
LS_COLORS=$LS_COLORS:'ow=1;34:tw=1;34:' ; export LS_COLORS


PROMPT_COMMAND='echo -en "\033]0; $(pwd) \a"'

PATH=$PATH:~/.dotfiles/local-bin


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
    if ! ./gradlew clean test integrationTest; then
        xdg-open build/reports/tests/index.html &> /dev/null
        return 1
    else
        notify-send 'TEST WAS SUCCESSFUL!'
    fi
}

##
# Opens the test report if it exists
##
function openTestReport() {
    UNIT_TEST_REPORT=build/reports/tests/test/index.html
    INTEGRATION_TEST_REPORT=build/reports/tests/index.html
    if [ -f "$INTEGRATION_TEST_REPORT" ]; then
        echo "Opening integration test report..."
        xdg-open $INTEGRATION_TEST_REPORT &> /dev/null
    elif [ -f "$UNIT_TEST_REPORT" ]; then
        echo "Opening unit test report..."
        xdg-open $UNIT_TEST_REPORT &> /dev/null
    else
        echo "No test report found"
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

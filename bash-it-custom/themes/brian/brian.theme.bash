# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.


SCM_THEME_PROMPT_DIRTY=" ${red?}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
SCM_THEME_PROMPT_PREFIX=" ${green?}|"
SCM_THEME_PROMPT_SUFFIX="${green?}|"

GIT_THEME_PROMPT_DIRTY=" ${red?}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
GIT_THEME_PROMPT_PREFIX=" ${green?}|"
GIT_THEME_PROMPT_SUFFIX="${green?}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

function __bobby_clock() {
	printf '%s' "$(clock_prompt) "
}


function prompt_command() {
	PS1="\[\033]0;\w\007\]" #sets the terminal title
	PS1+="\n$(__bobby_clock)"
	PS1+="${yellow?}"
	PS1+="${purple?}\h "
	PS1+="${reset_color?}in "
	PS1+="${green?}\w\n"
	PS1+="${bold_cyan?}$(scm_prompt_char_info) "
	PS1+="${green?}→${reset_color?} "
}


: "${THEME_SHOW_CLOCK_CHAR:="true"}"
: "${THEME_CLOCK_CHAR_COLOR:=${red?}}"
: "${THEME_CLOCK_COLOR:=${bold_cyan?}}"
: "${THEME_CLOCK_FORMAT:="%Y-%m-%d %H:%M:%S"}"

safe_append_prompt_command prompt_command

#!/usr/bin/env zsh
# DarkFusion ZSH Theme

# Uncomment next line to remove the added space on the right of the RPROMPT.
#ZLE_RPROMPT_INDENT=0

# Python Virtual Environment prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="[%{$fg_bold[magenta]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}]─"

# Git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}git%{$fg_bold[default]%}:"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

# Git status states
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[cyan]%}∆%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}ε%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}µ%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?%{$reset_color%}"

function ssh_connection {
  [[ -n $SSH_CONNECTION ]] && echo "[%{$fg_bold[red]%}SSH%{$reset_color%}]" && return
}

function custom_git_prompt {
    GIT_PROMPT_INFO=$(git_prompt_info)
    GIT_STATUS=$(git_prompt_status)
    [[ -n ${GIT_STATUS} ]] && GIT_STATUS="$GIT_STATUS"
    [[ -n ${GIT_PROMPT_INFO} ]] || return
    echo "[${GIT_PROMPT_INFO:t} ${GIT_STATUS}]─"
}

# Display the current Python Virtual Environment.
# If no virtual environment is active, nothing is displayed.
function virtualenv_prompt_info {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

function prompt_char {
    [ "$EUID" -eq 0 ] && echo "[%{$fg[red]%}#%{$reset_color%}]" && return
    echo "[%{$fg[green]%}$%{$reset_color%}]"
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local current_user="%{$fg_bold[green]%}%n%{$reset_color%} %{$fg_bold[default]%}at%{$reset_color%} %{$fg_bold[green]%}%m%{$reset_color%}"
local working_directory="%{$fg_bold[cyan]%}%~%{$reset_color%}"

PROMPT='╭─[${current_user}] [${working_directory}] $(ssh_connection)
╰─$(virtualenv_prompt_info)$(custom_git_prompt)%{$reset_color%}$(prompt_char) '
RPROMPT='${return_code} [%{$fg[yellow]%}%D{%m-%d-%Y} %{$reset_color%}at%{$fg[yellow]%} %D{%H:%M:%S}%{$reset_color%}]'

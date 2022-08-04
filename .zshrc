#!/usr/bin/env zsh

# allow colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# customized prompt
autoload -Uz vcs_info
precmd() {
    vcs_info
    setopt prompt_subst
    zstyle ':vcs_info:git:*' formats '%b'

    PROMPT='%F{yellow}$CONDA_PROMPT_MODIFIER%f' # conda environment
    # PROMPT+='%F{yellow}%n '                   # username
    PROMPT+='%F{magenta}%1~%f'                  # working directory

    # git branch (green if up to date, red if not)
    if [[ -n ${vcs_info_msg_0_} ]]; then
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            PROMPT+=' %F{red}${vcs_info_msg_0_}%f'
        else
            PROMPT+=' %F{green}${vcs_info_msg_0_}%f'
        fi
    else
        PROMPT+=''
    fi

    PROMPT+=' %# '    # standard zsh ending
}

# command shortcuts
alias kepubify='/Users/ahriley/kepubify-darwin-64bit'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ahriley/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ahriley/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ahriley/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ahriley/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

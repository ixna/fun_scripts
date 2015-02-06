# Set up the prompt

# Alias
alias gst='git-status'
alias ga='git-add'
alias gc='git-commit -m'
alias gp='git pull'
alias gs='git push'
alias grep='egrep -s --colour=auto'
alias nano='nano -w'

autoload -Uz promptinit  
autoload -Uz colors vcs_info
colors
promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

setopt prompt_subst
# Configuring vcs_info
zstyle ':vcs_info:*' stagedstr "%{$fg_bold[green]%}~"
zstyle ':vcs_info:*' unstagedstr "%{$fg_bold[yellow]%}+"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' branchformat '%b-%r'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
# hash changes branch misc
# Git
    
# zstyle ':vcs_info:git*' formats "[%{$fg[yellow]%}%12.12i%{$reset_color%} %u %{$fg[magenta]%}%b%{$reset_color%}%m] "
# zstyle ':vcs_info:git*' formats '[%F{green}%b%c%u%F{red}●%F{blue}] '
zstyle ':vcs_info:git*' actionformats "(%a)[%{$fg[yellow]%}%12.12i%{$reset_color%} %u %{$fg[magenta]%}%b%{$reset_color%}%m]"
#  zstyle ':vcs_info:git*' formats "%s  %r/%S %b %m%u%c "#  zstyle ':vcs_info:git*' formats "(%s)[%12.12i %u %b %m]"
#  zstyle ':vcs_info:git*' formats "%{$fg[grey]%}%s %{$reset_color%}%r/%S%{$fg[grey]%} %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%} "
#  zstyle ':vcs_info:git*' actionformats "(%s|%a)[%12.12i %u %b %m]"
# Mercurial
# zstyle ':vcs_info:hg*' formats "(%s)[%i%u %b %m]"
zstyle ':vcs_info:hg*' actionformats "(%s|%a)[%i%u %b %m]"
zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:(hg*|git*):*' check-for-changes true
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' get-mq true
zstyle ':vcs_info:hg*:*' get-unapplied true
zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' unstagedstr "+"
zstyle ':vcs_info:hg*:*' hgrevformat "%r" # only show local rev.
zstyle ':vcs_info:hg*:*' branchformat "%b" # only show branch
    
    
# use version control info - for prompt
zstyle ':vcs_info:*' enable git svn cvs hg bzr darcs
    
vcs_info_wrapper() {
#     if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
#             zstyle ':vcs_info:git*' formats '[%F{green}%b%c%u%F{blue}] '
#       } else {
            zstyle ':vcs_info:*' formats "%{$fg_bold[grey]%}[%{$reset_color%}%{$fg[red]%}%b%c%u%{$fg_bold[grey]%}]"
#       }
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg_bold[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}
# or use pre_cmd, see man zshcontrib
precmd() {
    vcs_info
}
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
            zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
      } else {
            zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}•%F{blue}]'
      }
      vcs_info
}
 
post_prompt="%b%f%k"

add-zsh-hook precmd prompt_adam1_precmd

prompt_adam1_precmd () {
# Prompt
if [[ $EUID == 0 ]]
then
PS1='%{$fg_bold[green]%}%n@%m%k %{$fg_bold[blue]%} : %~ $(vcs_info_wrapper)%{$prompt_newline%}%{$fg_bold[white]%}#%{$reset_color%} $post_prompt'  # user dir #
else
PS1='%{$fg_bold[green]%}%n@%m%k %{$fg_bold[blue]%} : %~ $(vcs_info_wrapper)$prompt_newline%F{white} %# $post_prompt'  # user dir #
fi
# RPROMPT=$'$(git_super_status)%{\e[1;30m%}%T\ %D{%a}\ %D{%Y-%m-%d}\ %n@%m%{\e[0m%}' # right prompt with time #
}

# Set xterm title
case $TERM in (xterm*|rxvt)
precmd () { print -Pn "\e]0;%n@%m: %~\a" }
preexec () { print -Pn "\e]0;%n@%m: $1\a" }
;;
esac
    
# Grep colors
GREP_OPTIONS='--color=auto'
#GREP_COLOR='5;38' #п╪п╦пЁп╟я▌я┴п╦п╧
GREP_COLOR='1;33' #я▐я─п╨п╬-п╤п╣п╩я┌я▀п╧ п╫п╟ я┤п╣я─п╫п╬п╪
export GREP_OPTIONS GREP_COLOR
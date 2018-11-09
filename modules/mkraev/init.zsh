  #Custom functino from MaximKraev

name() {
 name=$1
 vared -c -p 'rename to: ' name
 command mv $1 $name
}
compdef name rename

# мои функции
#
ccd() { cd $1 && ls}
# создать директорию и перейти в нее
mcd(){ mkdir $1; cd $1 }
# если текущая директория пустая, то удалить ее и перейти в родительскую директорию
rcd(){ local P="`pwd`"; cd .. && rmdir "$P" || cd "$P"; }

# разукрашиваем некоторые команды с помощью grc
[[ -x `which grc` ]] && {
 GRC=`which grc`
 alias ping="$GRC --colour=auto ping -c 4"
 alias traceroute="$GRC --colour=auto traceroute"
 alias make="$GRC --colour=auto make"
 alias diff="$GRC --colour=auto diff"
 alias cvs="$GRC --colour=auto cvs"
 alias netstat="$GRC --colour=auto netstat"
 # разукрашиваем логи с помощью grc
 alias logf="$GRC tailf"
 alias logt="$GRC tail"
 alias logc="$GRC cat"
 alias logh="$GRC head"
}

#alias gst="git status"
alias gcm="git checkout master"

# принудимтельное удаление без коррекции
alias rmf='rm -f'
# принудительное рекурсивное удаление без коррекции
alias rmrf='rm -fR'

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g Gi='| grep -i'
alias -g L="| less"

if [[ "${TERM_PROGRAM}" == "iTerm.app" ]]; then
  alias copy='pbcopy <'
else
  alias copy='gpaste-client <'
fi
alias clean_color='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias mpv-nv='mpv --profile=no-video'

#escape urls
# autoload -U url-quote-magic
# zle -N self-insert url-quote-magic

# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic

# if archlinux use gems in local folder
if [[ -x `which pacman` ]]; then
  export PATH="`ruby -rubygems -e 'puts Gem.user_dir'`/bin:$PATH"
  export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
fi
if [[ "${TERM_PROGRAM}" == "iTerm.app" ]]; then
  export PATH="`ruby -rubygems -e 'puts Gem.user_dir'`/bin:$PATH"
  export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
fi

if [[ -x `which subl` ]]; then
    alias s=subl
fi

if [ "$SSH_TTY$DISPLAY" = "${DISPLAY#*:[1-9][0-9]}" ]; then
  export EDITOR='code -w -n'
else
  export EDITOR=vim
fi

export VISUAL=$EDITOR

if [ -d "$HOME/bin" ] ; then
  export PATH=${HOME}/bin:${PATH}
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH=$HOME/.local/bin:$PATH
fi

#npm

export PATH=node_modules/.bin:${PATH}

#go
if [ -d "${HOME}/Projects/go" ] ; then
    export GOPATH=$HOME/Projects/go
fi
if [ -d "${HOME}/Projects/go/bin" ] ; then
    export PATH=${PATH}:${HOME}/Projects/go/bin
fi


source "${0:h}/aliases.zsh"

# if [ -n "$TMUX" ]; then
#   function refresh {
#     export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
#     export $(tmux show-environment | grep "^DISPLAY")
#     export $(tmux show-environment | grep "^XAUTHORITY")
#     export $(tmux show-environment | grep "^SSH_ASKPASS")
#     export $(tmux show-environment | grep "^SSH_AGENT_PID")
#     export $(tmux show-environment | grep "^DBUS_SESSION_BUS_ADDRESS")
#   }
# else
#   function refresh { }
# fi

# function preexec {
#     refresh
# }
#export PULSE_LATENCY_MSEC=60

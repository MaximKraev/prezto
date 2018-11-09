#
# Maintains a frequently used file and directory list for fast access.
#
# Authors:
#   Wei Dai <x@wei23.net>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'editor'

# If the command doesn't exist externally, we need to fall back to the bundled
# submodule.
if (( ! $+commands[fasd] )); then
  source "${0:h}/external/fasd" || return 1
fi

#
# Initialization
#

cache_file="${TMPDIR:-/tmp}/prezto-fasd-cache.$UID.zsh"
if [[ "${commands[fasd]}" -nt "$cache_file" \
      || "${ZDOTDIR:-$HOME}/.zpreztorc" -nt "$cache_file" \
      || ! -s "$cache_file"  ]]; then
  # Set the base init arguments.
  init_args=(zsh-hook)

  # Set fasd completion init arguments, if applicable.
  if zstyle -t ':prezto:module:completion' loaded; then
    init_args+=(zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)
  fi

  # Cache init code.
  fasd --init "$init_args[@]" >! "$cache_file" 2> /dev/null
fi

source "$cache_file"

unset cache_file init_args

# function fasd_cd {
#   local fasd_ret="$(fasd -d "$@")"
#   if [[ -d "$fasd_ret" ]]; then
#     cd "$fasd_ret"
#   else
#     print "$fasd_ret"
#   fi
# }


fasd_cd() {
  if [ $# -lt 1 ]; then
    fasd "$@"
  else
    local _fasd_ret=$(fasd -l -1 -d "$@")
    local _pwd=$(pwd)
    if [ "$_pwd" = "$_fasd_ret" ]; then
      _fasd_ret=$(fasd -l -2 -d "$@")
    fi
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s "$_fasd_ret"
  fi
}

#
# Aliases
#

# Changes the current working directory interactively.
alias j='fasd_cd'

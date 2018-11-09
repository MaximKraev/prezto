#git
  alias gcom='git checkout master'

alias ping='ping -c 5'
alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias path='echo -e ${PATH//:/\\n}'
alias mkdir='mkdir -pv'
# get top process eating memory
alias psmem='ps -e -orss=,args= | sort -b -k1,1n'
alias psmem10='ps -e -orss=,args= | sort -b -k1,1n| head -10'
# get top process eating cpu if not work try excute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr | head -10'
# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias gbclean='git fetch -p && git branch --merged master | grep -v "\* master" | grep -v "master" | xargs -n 1 git branch -d'

brightness() {
    /usr/local/bin/ddcctl -d 1 -b "$@0"
}

volume() {
    /usr/local/bin/ddcctl -d 1 -v "$@0"
}

# directory LS
dls () {
    ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"
}
psgrep() {
    ps aux | grep -i "$@" | grep -v grep
}
# Kills any process that matches a regexp passed to it
killit() {
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# list contents of directories in a tree-like format
if [ -z "\${which tree}" ]; then
  tree () {
      find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi

# Sort connection state
sortcons() {
    netstat -nat |awk '{print $6}'|sort|uniq -c|sort -rn
}

# View all 80 Port Connections
con80() {
    netstat -nat|grep -i ":80"|wc -l
}

# On the connected IP sorted by the number of connections
sortconip() {
    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
}

autoload -U compinit promptinit
compinit
promptinit
unsetopt correct_all
EDITOR=vim
ZDOTDIR="$HOME/.zsh"

export LANG=en_US.UTF-8

## color stderr differently
#if [ -f "/usr/lib/libstderred.so" ]; then
#    export LD_PRELOAD="/usr/lib/libstderred.so"
#fi


# }}}
# Keybindings {{{
bindkey -e
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[3~' delete-char
bindkey '\e[2~' overwrite-mode
bindkey "^[[7~" beginning-of-line # Pos1
bindkey "^[[8~" end-of-line # End
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[OH" beginning-of-line
bindkey '^[OF' end-of-line
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line

# HOWTO make your own:
# bindkey '<crtl+v key>' action
# for some actions run `bindkey`

# add edit command line feature ("alt
autoload edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line



# Colors {{{
#use these in functions/shell scripts
export NC='\e[0m'
export white='\e[0;30m'
export WHITE='\e[1;30m'
export red='\e[0;31m'
export RED='\e[1;31m'
export green='\e[0;32m'
export GREEN='\e[1;32m'
export yellow='\e[0;33m'
export YELLOW='\e[1;33m'
export blue='\e[0;34m'
export BLUE='\e[1;34m'
export magenta='\e[0;35m'
export MAGENTA='\e[1;35m'
export cyan='\e[0;36m'
export CYAN='\e[1;36m'
export black='\e[0;37m'
export BLACK='\e[1;37m'

# these are for use in PROMPT
p_nc=$'%{\e[0m%}'
p_white=$'%{\e[0;30m%}'
p_WHITE=$'%{\e[1;30m%}'
p_red=$'%{\e[0;31m%}'
p_RED=$'%{\e[1;31m%}'
p_green=$'%{\e[0;32m%}'
p_GREEN=$'%{\e[1;32m%}'
p_yellow=$'%{\e[0;33m%}'
p_YELLOW=$'%{\e[1;33m%}'
p_blue=$'%{\e[0;34m%}'
p_BLUE=$'%{\e[1;34m%}'
p_magenta=$'%{\e[0;35m%}'
p_MAGENTA=$'%{\e[1;35m%}'
p_cyan=$'%{\e[0;36m%}'
p_CYAN=$'%{\e[1;36m%}'
p_black=$'%{\e[0;37m%}'
p_white=$'%{\e[1;37m%}'

# some better colors for ls
eval "`dircolors ~/.dircolors`"

# }}}
# Prompt {{{

# necessary if you want to use functions in the prompt
# without this they wouldn't be run again
#precmd () {
# this has to be on the edge or you have some spaces in the prompt
# if you have any workaround please tell
if [[ $UID != 0 ]]; then
  local username_color=$p_blue
else
  local username_color=$p_red
fi
local host_color=$p_GREEN
local path_color=$p_BLUE
PROMPT="${username_color}$USERNAME${p_nc}@${host_color}%m${p_nc} ${path_color}%~${p_nc} > "
#}

function _7slash {
   if [[ $words[CURRENT] = 7(#b)(*)(#e) ]]
   then
     compadd -U -X 'Correct leading 7 to /' -f /$match[1]
   fi
}


## Spelling prompt
SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

ls () {
  /bin/ls -hbF --group-directories-first --color=auto $@ &&
}

# from the grml zshrc iirc
hglob() {
  echo -e "
      /      directories
      .      plain files
      @      symbolic links
      =      sockets
      p      named pipes (FIFOs)
      *      executable plain files (0100)
      %      device files (character or block special)
      %b     block special files
      %c     character special files
      r      owner-readable files (0400)
      w      owner-writable files (0200)
      x      owner-executable files (0100)
      A      group-readable files (0040)
      I      group-writable files (0020)
      E      group-executable files (0010)
      R      world-readable files (0004)
      W      world-writable files (0002)
      X      world-executable files (0001)
      s      setuid files (04000)
      S      setgid files (02000)
      t      files with the sticky bit (01000)
   print *(m-1)          # Dateien, die vor bis zu einem Tag modifiziert wurden.
   print *(a1)           # Dateien, auf die vor einem Tag zugegriffen wurde.
   print *(@)            # Nur Links
   print *(Lk+50)        # Dateien die ueber 50 Kilobytes grosz sind
   print *(Lk-50)        # Dateien die kleiner als 50 Kilobytes sind
   print **/*.c          # Alle *.c - Dateien unterhalb von \$PWD
   print **/*.c~file.c   # Alle *.c - Dateien, aber nicht 'file.c'
   print (foo|bar).*     # Alle Dateien mit 'foo' und / oder 'bar' am Anfang
   print *~*.*           # Nur Dateien ohne '.' in Namen
   chmod 644 *(.^x)      # make all non-executable files publically readable
   print -l *(.c|.h)     # Nur Dateien mit dem Suffix '.c' und / oder '.h'
   print **/*(g:users:)  # Alle Dateien/Verzeichnisse der Gruppe >users<
   echo /proc/*/cwd(:h:t:s/self//) # Analog zu >ps ax | awk '{print $1}'<"
}

# }}}
# History {{{
export HISTFILE=~/.zsh/histfile
export HISTSIZE=10000
export SAVEHIST=500000
#readonly HISTFILE
# }}}

# Other ZSH options {{{
autoload -U colors
colors

autoload -U zmv

# .. -> cd ../
setopt autocd

# cd /etc/**/foo/blub searches ;)
setopt extendedglob

# push cds to directory stack
setopt auto_pushd

# don't push something twice
setopt pushd_ignore_dups

# don't kill jobs when exiting shell
setopt no_hup
# and don't warn
setopt no_check_jobs

setopt inc_append_history
setopt no_bg_nice
setopt share_history
setopt bang_hist
setopt extended_history
#setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_find_no_dups
setopt nohistverify
setopt prompt_subst
#setopt hist_fcntl_lock
setopt always_to_end
setopt nohistfcntllock

unsetopt auto_remove_slash

alias rm='rm -Iv'
alias cp='cp -iv'
alias mv='mv -iv'

zstyle :compinstall filename '$HOME/.zshrc'

# performance tweaks
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache
zstyle ':completion:*' use-perl on

# completion colours
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _complete _match _approximate _7slash
zstyle ':completion:*:match:*' original only

# allow more mistypes if longer command
#zstyle -e ':completion:*:approximate:*' \
#        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# ignore completion for commands we don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# get rid of .class and .o files for vim
zstyle ':completion:*:vim:*' ignored-patterns '*.(class|o)'

# show menu when tabbing
zstyle ':completion:*' menu yes select

# better completion for kill
zstyle ':completion:*:*:kill:*' command 'ps --forest -u$USER -o pid,%cpu,tty,cputime,cmd'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
compdef pkill=killall

# bugged with zsh 4.3.10 for whatever reason
zstyle ':completion:*' file-sort time
#zstyle ':completion:*' file-sort name

# Ignore same file on rm
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

zstyle ':completion:*:wine:*' file-patterns '*.(exe|EXE):exe'

# don't complete usernames (the come from localhost!)
zstyle ':completion:*:(ssh|scp):*' users

# complete ssh hostnames
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}%%:*}#\[}%\]}) ||
_ssh_hosts=()
[[ -r ~/.ssh/config ]] && _ssh_config_hosts=($(sed -rn 's/host\s+(.+)/\1/ip' "$HOME/.ssh/config" | grep -v "\*" )) ||
_ssh_config_hosts=()
hosts=(
        $HOST
        "$_ssh_hosts[@]"
        $_ssh_config_hosts[@]
        localhost
    )
zstyle ':completion:*:hosts' hosts $hosts

# automagic url quoter
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# e.g. ls foo//bar -> ls foo/bar
zstyle ':completion:*' squeeze-slashes true

# if in foo/bar don't show bar when cd ../<TAB>
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Prevent lost+found directory from being completed
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found'

# ignore case when completing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# make some stuff look better
# from: http://ft.bewatermyfriend.org/comp/zsh/zshrc.d/compsys.html
zstyle ':completion:*:descriptions' format "- %{${fg[yellow]}%}%d%{${reset_color}%} -"
zstyle ':completion:*:messages'     format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
zstyle ':completion:*:corrections'  format "- %{${fg[yellow]}%}%d%{${reset_color}%} - (%{${fg[cyan]}%}errors %e%{${reset_color}%})"
zstyle ':completion:*:default'      \
	select-prompt \
	"%{${fg[yellow]}%}Match %{${fg_bold[cyan]}%}%m%{${fg_no_bold[yellow]}%}  Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[red]}%}
%p%{${reset_color}%}"
zstyle ':completion:*:default'      \
	list-prompt   \
	"%{${fg[yellow]}%}Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[yellow]}%}  Continue?%{${reset_color}%}"
zstyle ':completion:*:warnings'     \
	format        \
	"- %{${fg_no_bold[red]}%}no match%{${reset_color}%} - %{${fg_no_bold[yellow]}%}%d%{${reset_color}%}"
zstyle ':completion:*' group-name ''

# manual pages are sorted into sections
# from: http://ft.bewatermyfriend.org/comp/zsh/zshrc.d/compsys.html
zstyle ':completion:*:manuals'       separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections   true

### highlight the original input.
    zstyle ':completion:*:original' \
        list-colors "=*=$color[red];$color[bold]"

### highlight words like 'esac' or 'end'
    zstyle ':completion:*:reserved-words' \
        list-colors "=*=$color[red]"

### colorize hostname completion
    zstyle ':completion:*:*:*:*:hosts' \
        list-colors "=*=$color[cyan];$color[bg-black]"

### colorize username completion
    zstyle ':completion:*:*:*:*:users' \
        list-colors "=*=$color[red];$color[bg-black]"

### colorize processlist for 'kill'
    zstyle ':completion:*:*:kill:*:processes' \
        list-colors "=(#b) #([0-9]#) #([^ ]#)*=$color[none]=$color[yellow]=$color[green]"

#

keychain --quiet id_rsa
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        . $HOME/.keychain/$HOSTNAME-sh-gpg
#source $HOME/bin/gpg-agent.sh
#export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

pa-list() { pacmd list-sinks | awk '/index/ || /name:/' ;}
pa-set() {
    # list all apps in playback tab (ex: cmus, mplayer, vlc)
    inputs=($(pacmd list-sink-inputs | awk '/index/ {print $2}'))
    # set the default output device
    pacmd set-default-sink $1 &> /dev/null
    # apply the changes to all running apps to use the new output device
    for i in ${inputs[*]}; do pacmd move-sink-input $i $1 &> /dev/null; done
}
pa-playbacklist() {
    # list individual apps
    echo "==============="
    echo "Running Apps"
    pacmd list-sink-inputs | awk '/index/ || /application.name /'

    # list all sound device
    echo "==============="
    echo "Sound Devices"
    pacmd list-sinks | awk '/index/ || /name:/'
}
pa-playbackset() {
    # set the default output device
    pacmd set-default-sink "$2" &> /dev/null
    # apply changes to one running app to use the new output device
    pacmd move-sink-input "$1" "$2" &> /dev/null
}

sc () { echo $@ | socat - UNIX-CONNECT:/tmp/spotifyd 2>/dev/null; }

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
# Base16 Shell
BASE16_SHELL="$HOME/bin/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

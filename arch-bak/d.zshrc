# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dinge/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# af-magic / tjkirch / ys / alanpeabody
# ZSH_THEME="robbyrussell"

# ---------------------
# export LC_ALL=C
# unset LC_ALL

# ---------------------
# # if [ "$TERM" = "linux" -o  "$TERM" = "screen" ];then
# if [ "$TERM" != "linux" ];then
#   # unset LC_ALL
#   # export LANGUAGE=zh_CN
#   # export LANG=zh_CN.UTF-8
#   if [ "$TERM" = "screen" ];then
#     ZSH_THEME="tjkirch"
#   else
#     ZSH_THEME="robbyrussell"
#   fi
# else
#   # export LC_ALL=C
#   # export LANGUAGE=en_US
#   # export LANG=en_US.UTF-8
#   ZSH_THEME="tjkirch"
# fi

# ---------------------
# ZSH_THEME="Chicago95"
ZSH_THEME="Chicago95_Dinge"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ==========================================
## DING.YI - START

# alias ---------
# alias open="pcmanfm"
alias open="thunar"
alias ra="ranger"
alias s="neofetch"
alias c="clear"

alias vi="nvim"
alias vim="TERM=xterm-256color /usr/bin/vim"
alias vimtutor="LANG=zh_CN.utf-8 vimtutor"

# alias code="code --disable-gpu"
# alias eServer="egretServer"

# 当临时连接的外接键盘，需要再次设置键位
alias keyboardset="xmodmap ~/.Xmodmap"

# NetworkManager systemd
alias netstart="sudo systemctl start NetworkManager"
alias netstop="sudo systemctl stop NetworkManager"

# vmware net systemd
alias vmnetstart="sudo systemctl start vmware-networks.service"
alias vmnetstop="sudo systemctl stop vmware-networks.service"

# vmware usb systemd
alias vmusbstart="sudo systemctl start vmware-usbarbitrator.service"
alias vmnetstop="sudo systemctl stop vmware-usbarbitrator.service"

# vmware 共享 systemd
alias vmhoststart="sudo systemctl start vmware-hostd.service"
alias vmhoststop="sudo systemctl stop vmware-hostd.service"

# bluetooth systemd
alias bluestart="sudo systemctl start bluetooth"
alias bluestop="sudo systemctl stop bluetooth"

# sshd systemd
alias sshstart="sudo systemctl start sshd"
alias sshstop="sudo systemctl stop sshd"

# docker systemd
alias dockerstart="sudo systemctl start docker"
alias dockerstop="sudo systemctl stop docker"
# alias docker="sudo docker"

# path ---------
# /dinge/software/bin
export PATH="/home/dinge/core/software/bin:$PATH"
# /home/dinge/.local/bin
export PATH="/home/dinge/.local/bin:$PATH"

# egret
# export PATH="/dinge/software/egret/egret-core/tools/bin:$PATH"
# # export PATH="/dinge/software/egret/egret-core-5.2.33/tools/bin:$PATH"

# godot engine
# export GODOT_BIN="/dinge/software/bin/godot-50-v3.2.2"

# npm
export PATH="/home/dinge/core/library/npm-global/bin:$PATH"

# nim lang
export PATH="/home/dinge/.nimble/bin:$PATH"

# go lang
export GOROOT=/usr/lib/go
export GOPATH=/home/dinge/core/workspace/go
export GOBIN=/home/dinge/core/workspace/go/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN

# vpn ssr
# export http_proxy="http://127.0.0.1:12333"
# export https_proxy="http://127.0.0.1:12333"

# ubuntu gdm login page
alias gdmstart="sudo systemctl start gdm"
alias gdmstop="sudo systemctl stop gdm"

# clash
alias clash="/home/dinge/core/software/clash/clash -d /home/dinge/core/software/clash/"

# net cat
alias net_hogs="sudo nethogs ens160"
alias net_iftop="sudo iftop -i ens160"
alias net_nload="nload ens160 -u K"
alias net_iptraf="sudo iptraf-ng"

alias vpnstart="export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7891;echo \"Set proxy successfully\" "
alias vpnstop="unset http_proxy;unset https_proxy;unset all_proxy;echo \"Unset proxy successfully\" "
alias ipcn="curl myip.ipip.net"
alias ip="curl ip.sb"

# shell run -> proxy_on
function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy=$http_proxy
    export all_proxy=socks5://127.0.0.1:7890
    curl www.google.com
    echo -e "\n"
    echo -e "\033[32m已开启代理\033[0m"
}
# shell run -> proxy_off
function proxy_off() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo -e "已关闭代理"
}

# vpn v2ray
#export http_proxy="http://127.0.0.1:7890"
#export https_proxy="http://127.0.0.1:7890"

# powerline
# powerline-daemon -q
# . /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

# DING.YI - END
# ==========================================

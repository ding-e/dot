# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="/Users/dinge/.oh-my-zsh"
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# MACOS
if [[ $(uname -o) = "Darwin" ]]; then
ZSH_THEME="dinge"
else # LINUX
if [[ $(uname -n) = "de-alpine" ]]; then
ZSH_THEME="norm"
elif [[ $(uname -n) = "de-arch" ]] || [[ $(uname -n) = "de-ubuntu" ]]; then
ZSH_THEME="Chicago95_Dinge"
if [[ ${VIMRUNTIME} != "" ]]; then
ZSH_THEME="dinge-minimal"
fi
# ZSH_THEME="dinge2"
# if [[ ${TERM_PROGRAM} = "tmux" ]]; then
# ZSH_THEME="Chicago95_Dinge"
# fi
fi
fi

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

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# -------------- DINGE -------------- #


# =========================================================
# MACOS.START
if [[ $(uname -o) = "Darwin" ]]; then


# workspace
export WORKSPACE_PATH="$HOME/Documents/Workspace"

# docker
# alias archlinux="docker exec -it -u dinge -w /home/dinge de-arch zsh"
alias alpine="docker exec -it -u dinge -w /home/dinge w1 zsh"
alias ubuntu="docker exec -it -u dinge -w /home/dinge de-ubuntu zsh"
alias gdocker="cd ~/Desktop/碼頭工人/"
# -----------------------------
# multipass
alias mp="multipass"
# alias ubuntu="multipass exec de-ubuntu -- sudo -i -u dinge -- tmux"
# alias alpine="multipass exec de-ubuntu -- sudo -i -u dinge -- docker exec -it -u dinge -w /home/dinge d1 zsh"

# 配置 /etc/apache2/httpd.conf
# 默认根目录: /Library/WebServer/Documents/
alias apachestart="sudo apachectl start"
alias apachestop="sudo apachectl stop"
alias apacherestart="sudo apachectl restart"

# mac pkg_uninstall
# https://github.com/mpapis/pkg_uninstaller
# export PATH=$HOME/Documents/Tool/pkg_uninstaller:$PATH

# brew
# export PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$PATH
# export CPATH=/opt/homebrew/include:$CPATH
# export LIBRARY_PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$LIBRARY_PATH
# export LD_LIBRARY_PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$LD_LIBRARY_PATH
# export DYLD_LIBRARY_PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$DYLD_LIBRARY_PATH
#
# export HOMEBREW_NO_AUTO_UPDATE=1
# export HOMEBREW_NO_INSTALL_CLEANUP=1


# MACOS.END
# =========================================================
# LINUX.START
else


# workspace
export WORKSPACE_PATH="$HOME/core/workspace"

# export SHELL="/bin/zsh"

# 当临时连接的外接键盘，需要再次设置键位
# alias keyboardset="xmodmap ~/.Xmodmap"

# NetworkManager systemd
# alias netstart="sudo systemctl start NetworkManager"
# alias netstop="sudo systemctl stop NetworkManager"

# vmware net systemd
# alias vmnetstart="sudo systemctl start vmware-networks.service"
# alias vmnetstop="sudo systemctl stop vmware-networks.service"

# vmware usb systemd
# alias vmusbstart="sudo systemctl start vmware-usbarbitrator.service"
# alias vmnetstop="sudo systemctl stop vmware-usbarbitrator.service"

# vmware 共享 systemd
# alias vmhoststart="sudo systemctl start vmware-hostd.service"
# alias vmhoststop="sudo systemctl stop vmware-hostd.service"

# bluetooth systemd
# alias bluestart="sudo systemctl start bluetooth"
# alias bluestop="sudo systemctl stop bluetooth"

# sshd systemd
alias sshstart="sudo systemctl start sshd"
alias sshstop="sudo systemctl stop sshd"
alias sshstatus="sudo systemctl status sshd"

# docker systemd
alias dockerstart="sudo systemctl start docker"
alias dockerstop="sudo systemctl stop docker"
alias dockerdisable="sudo systemctl disable docker"
alias dockerstatus="sudo systemctl status docker"
alias dockersocketstop="sudo systemctl stop docker.socket"
alias dockersocketdisable="sudo systemctl stop docker.socket"

# docker
# alias archlinux="docker exec -it -u dinge -w /home/dinge de-arch zsh"
alias alpine="docker exec -it -u dinge -w /home/dinge w1 zsh"
# alias ubuntu="docker exec -it -u dinge -w /home/dinge de-ubuntu zsh"

# ubuntu gdm login page
# alias gdmstart="sudo systemctl start gdm"
# alias gdmstop="sudo systemctl stop gdm"

# bin path ---------
# /home/dinge/core/bin
export PATH="$HOME/core/bin:$HOME/.dwm/bin:$PATH"
# # /home/dinge/.local/bin
# export PATH="$HOME/.local/bin:$PATH"

alias open="thunar"

# 注销
alias kdinge="pkill -kill -u dinge"
alias ktmp="pkill -kill -u tmp"

# parallels共享目錄
alias gshare="cd $HOME/share/linux/"

# dwm脚本启动目录
alias gscript="cd $HOME/.dwm/"

# clash
alias clash="$HOME/core/bin/clash/clash -d $HOME/core/bin/clash/"

# net cat
alias net_hogs="sudo nethogs enp0s1"
alias net_iftop="sudo iftop -i enp0s1"
alias net_nload="nload enp0s1 -u K"
alias net_iptraf="sudo iptraf-ng"

# npm
export PATH="$HOME/core/library/npm-global/bin:$PATH"


fi
# LINUX.END
# =========================================================


# term color
# export TERM="screen-256color"
export TERM="xterm-256color"

alias c="clear"
alias nf="neofetch"
alias ra="ranger"

alias vi="/usr/bin/vim"
alias vim="nvim"
# alias vim="TERM=xterm-256color /usr/bin/vim"
# alias vimtutor="LANG=zh_CN.utf-8 vimtutor"

alias dot="cd $WORKSPACE_PATH/dot/ && vim"
alias gwork="cd $WORKSPACE_PATH/"
alias gdot="cd $WORKSPACE_PATH/dot/"

alias gc="cd $WORKSPACE_PATH/c/"
alias gnim="cd $WORKSPACE_PATH/nim/"
alias gzig="cd $WORKSPACE_PATH/zig/"
alias grust="cd $WORKSPACE_PATH/rust/"
alias glove="cd $WORKSPACE_PATH/love2d/"
alias gweb="cd $WORKSPACE_PATH/web/www/"

alias gvim="cd $HOME/.config/nvim/"
alias glocal="cd $HOME/.local/share/"

# NVIM_LISTEN_ADDRESS=/tmp/nvimsockeyt nvim
alias ggodot="cd $WORKSPACE_PATH/godot/"

# 天氣 (chubin/wttr.in)
alias wttr="curl 'wttr.in/?lang=zh'"
alias wttr_s="curl 'wttr.in/?lang=zh&format=4'"

# 批量删除当前目录下的所有.DS_Store文件
alias deldsstore="find . -name '.DS_Store' -exec rm {} \;"
alias finddsstore="find . -name '.DS_Store'"

# vpn
alias vpnstart="export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7891;echo \"Set proxy successfully\" "
alias vpnstop="unset http_proxy;unset https_proxy;unset all_proxy;echo \"Unset proxy successfully\" "
alias ipcn="curl myip.ipip.net"
alias ip="curl ip.sb"

# shell run -> proxy_on
function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy=$http_proxy
    export all_proxy="socks5://127.0.0.1:7890"
    #curl www.google.com
    #echo -e "\n"
    echo -e "\033[32m已开启代理\033[0m"
}
# shell run -> proxy_off
function proxy_off() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo -e "已关闭代理"
}

# fzf 模糊搜索
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# go lang
# export GOPATH="$WORKSPACE_PATH/go"
# export GOBIN="$GOPATH/bin"
# export PATH=$GOBIN:$GOPATH:$PATH

# haxe lang
# HAXE_STD_PATH="/opt/homebrew/lib/haxe/std"
# alias openfl="haxelib run openfl"
# alias lime="haxelib run lime"
# alias flixel="haxelib run flixel-tools"

# nim lang
# langserver : nimble install nimlangserver
# nimlsp: 编译nimlsp必须制定源码目录
# nimble install \
  # -p:-d:explicitSourcePath:/xxx/nim/lsp/Nim-1.6.10 \
  # nimlsp --verbose
NIMBIN="$WORKSPACE_PATH/nim/bin/lang/Nim/bin"
export PATH=$NIMBIN:$PATH
NIMLIB="$HOME/.nimble/bin"
export PATH=$NIMLIB:$PATH

# zig lang - brew install zig --HEAD
#          - brew unlink zig && brew link --HEAD zig
ZIGBIN=$WORKSPACE_PATH/zig/bin/lang/zig-dev-0.11.0
export PATH=$ZIGBIN:$PATH
# --------------------
# zls - zig language server
#       git clone [-b 0.10.0] --recurse-submodules zls.git && build -Drelease-small
# zls -> zls.json path: /Users/dinge/Library/Application\ Support/zls.json
ZLSBIN="$WORKSPACE_PATH/zig/bin/lsp/zls/zig-out/bin"
export PATH=$ZLSBIN:$PATH


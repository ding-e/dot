# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/dinge/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="lambda"
ZSH_THEME="dinge"
# ZSH_THEME="Chicago95"
# ZSH_THEME="Chicago95_Dinge"

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
# zstyle ':omz:update' mode disabled  # disable automatic updates
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
alias c="clear"
alias s="neofetch"
alias ra="ranger"
alias vi="/usr/bin/vim"
alias vim="nvim"
#alias vim="TERM=xterm-256color /usr/bin/vim"
#alias vimtutor="LANG=zh_CN.utf-8 vimtutor"

# workspace
export WORKSPACE_PATH=~/Documents/Workspace
alias dot="cd $WORKSPACE_PATH/dot/ && vim"
alias gwork="cd $WORKSPACE_PATH/"
alias gdot="cd $WORKSPACE_PATH/dot/"
alias gnim="cd $WORKSPACE_PATH/nim/"
alias gzig="cd $WORKSPACE_PATH/zig/"
alias grust="cd $WORKSPACE_PATH/rust/"
alias gvim="cd ~/.config/nvim/"
alias glocal="cd ~/.local/share/"

# 解决tmux clear 提示 "terminals database is inaccessible" 问题
# [x] alias tmux="TERM=xterm-256color tmux"
#if [ "$TERM" = "tmux-256color" ];then
#    #export TERMINFO=/usr/share/terminfo
#    export TERM=xterm-256color
#else
#fi

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
# #export GOROOT=/opt/homebrew/Cellar/go/1.17.7/libexec
# #export GOPATH=$WORKSPACE_PATH/go
# #export GOBIN=$WORKSPACE_PATH/go/bin
# #export PATH=$PATH:$GOROOT/bin:$GOBIN
# export GOPATH=$WORKSPACE_PATH/go
# export GOBIN=$GOPATH/bin
# export PATH=$PATH:$GOBIN:$GOPATH

# haxe lang
# #export HAXE_STD_PATH="/opt/homebrew/lib/haxe/std"
# alias openfl="haxelib run openfl"
# alias lime="haxelib run lime"
# alias flixel="haxelib run flixel-tools"

# nim lang
# 安装nimlsp, 编译nimlsp必须制定源码目录
# nimble install \
  # -p:-d:explicitSourcePath:/Users/dinge/Documents/Workspace/nim/lsp/Nim-1.6.10 \
  # nimlsp --verbose
export NIMBIN=/Users/dinge/.nimble/bin
export PATH=$PATH:$NIMBIN
#export NIMSUGGEST=/opt/homebrew/bin/nimsuggest
#export PATH=$PATH:$NIMSUGGEST

# zig lang - brew install zig --HEAD
# export ZIGBIN=$WORKSPACE_PATH/zig/bin/lang/zig-macos-aarch64-0.10.0
#export ZIGBIN=$WORKSPACE_PATH/zig/bin/lang/zig-macos-aarch64-0.11.0
#export PATH=$ZIGBIN:$PATH

# zls - zig language server
# zls -> zls.json path: /Users/dinge/Library/Application\ Support/zls.json
# export ZLSBIN=$WORKSPACE_PATH/zig/bin/lsp/zls-0.10.0/zig-out/bin
export ZLSBIN=$WORKSPACE_PATH/zig/bin/lsp/zls-master/zig-out/bin
export PATH=$ZLSBIN:$PATH

# mac pkg_uninstall
# https://github.com/mpapis/pkg_uninstaller
# export PATH=/Users/dinge/Documents/Tool/pkg_uninstaller:$PATH

# brew
export PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$PATH
export CPATH=/opt/homebrew/include:$CPATH
export LIBRARY_PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=/opt/homebrew/Cellar:/opt/homebrew/lib:$DYLD_LIBRARY_PATH

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1


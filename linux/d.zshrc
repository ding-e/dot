#!/bin/bash

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
# ZSH_THEME="lambda"
# ZSH_THEME="dinge"
# ZSH_THEME="Chicago95"
ZSH_THEME="Chicago95_Dinge"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# -------------- DINGE -------------- #
# term color
export TERM="xterm-256color"

alias c="clear"
alias nf="neofetch"
alias ra="ranger"
#alias vi="/usr/bin/vim"
#alias vim="nvim"
#alias vim="TERM=xterm-256color /usr/bin/vim"
#alias vimtutor="LANG=zh_CN.utf-8 vimtutor"

## workspace
#export WORKSPACE_PATH=~/Documents/Workspace
#alias dot="cd $WORKSPACE_PATH/dot/ && vim"
#alias gwork="cd $WORKSPACE_PATH/"
#alias gdot="cd $WORKSPACE_PATH/dot/"
#alias gnim="cd $WORKSPACE_PATH/nim/"
#alias gzig="cd $WORKSPACE_PATH/zig/"
#alias grust="cd $WORKSPACE_PATH/rust/"
#alias gvim="cd ~/.config/nvim/"
#alias glocal="cd ~/.local/share/"

# 解决tmux clear 提示 "terminals database is inaccessible" 问题
# [x] alias tmux="TERM=xterm-256color tmux"
#if [ "$TERM" = "tmux-256color" ];then
#    #export TERMINFO=/usr/share/terminfo
#    export TERM=xterm-256color
#else
#fi

# 当临时连接的外接键盘，需要再次设置键位
#alias keyboardset="xmodmap ~/.Xmodmap"

# NetworkManager systemd
#alias netstart="sudo systemctl start NetworkManager"
#alias netstop="sudo systemctl stop NetworkManager"

# vmware net systemd
#alias vmnetstart="sudo systemctl start vmware-networks.service"
#alias vmnetstop="sudo systemctl stop vmware-networks.service"

# vmware usb systemd
#alias vmusbstart="sudo systemctl start vmware-usbarbitrator.service"
#alias vmnetstop="sudo systemctl stop vmware-usbarbitrator.service"

# vmware 共享 systemd
#alias vmhoststart="sudo systemctl start vmware-hostd.service"
#alias vmhoststop="sudo systemctl stop vmware-hostd.service"

# bluetooth systemd
#alias bluestart="sudo systemctl start bluetooth"
#alias bluestop="sudo systemctl stop bluetooth"

# sshd systemd
#alias sshstart="sudo systemctl start sshd"
#alias sshstop="sudo systemctl stop sshd"

# docker systemd
alias dockerstart="sudo systemctl start docker"
alias dockerstop="sudo systemctl stop docker"
alias dockerstatus="sudo systemctl status docker"
alias docker="sudo docker"

# ubuntu gdm login page
#alias gdmstart="sudo systemctl start gdm"
#alias gdmstop="sudo systemctl stop gdm"

# path ---------
## /dinge/software/bin
#export PATH="/home/dinge/core/software/bin:$PATH"
## /home/dinge/.local/bin
#export PATH="/home/dinge/.local/bin:$PATH"

# clash
#alias clash="/home/dinge/core/bin/clash/clash -d /home/dinge/core/bin/clash/"

# net cat
alias net_hogs="sudo nethogs enp0s1"
alias net_iftop="sudo iftop -i enp0s1"
alias net_nload="nload enp0s1 -u K"
alias net_iptraf="sudo iptraf-ng"

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

# npm
# export PATH="/Users/dinge/Documents/Library/npm-global/bin:$PATH"

# nim lang
# 安装nimlsp, 编译nimlsp必须制定源码目录
# nimble install \
  # -p:-d:explicitSourcePath:/Users/dinge/Documents/Workspace/nim/lsp/Nim-1.6.10 \
  # nimlsp --verbose
#export NIMBIN=/Users/dinge/.nimble/bin
#export PATH=$PATH:$NIMBIN
##export NIMSUGGEST=/opt/homebrew/bin/nimsuggest
##export PATH=$PATH:$NIMSUGGEST

# zig lang - brew install zig --HEAD
#          - brew unlink zig && brew link --HEAD zig
# export ZIGBIN=$WORKSPACE_PATH/zig/bin/lang/zig-macos-aarch64-0.10.0
#export ZIGBIN=$WORKSPACE_PATH/zig/bin/lang/zig-macos-aarch64-0.11.0
#export PATH=$ZIGBIN:$PATH

# zls - zig language server
#       git clone [-b 0.10.0] --recurse-submodules zls.git && build -Drelease-small
# zls -> zls.json path: /Users/dinge/Library/Application\ Support/zls.json
#export ZLSBIN=$WORKSPACE_PATH/zig/bin/lsp/zls-0.10.0/zig-out/bin
## export ZLSBIN=$WORKSPACE_PATH/zig/bin/lsp/zls-master/zig-out/bin
#export PATH=$ZLSBIN:$PATH


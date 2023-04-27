" vim与fzf 配合使用
set rtp+=/opt/homebrew/opt/fzf

" 编码为utf8
set encoding=utf-8

" =========================================
" DINGE.CODING START
" =========================================

" 取消搜索的高亮
let mapleader=" "
noremap <LEADER><CR> :nohlsearch<CR>
" 搜索结果光标移动并自动到屏幕中心
noremap = nzz
noremap - Nzz

" jj 映射 esc
inoremap jj <esc>
" ii 映射 回车
"inoremap ii <CR>

" 上下左右
"noremap i k
"noremap k j
"noremap j h
"noremap l l

" 当前光标插入
"noremap h i

" 快速上下左右跳转
"noremap [ 5i
"noremap ] 5k
"noremap { 7i
"noremap } 7k

" 光标移到当前行首个字符
" N key: go to the start of the line
noremap <C-n> 0
" 光标移到当前行最后字符
" I key: go to the end of the line
noremap <C-i> $

" vim剪切板与系统共享
"set clipboard+=unnamedplus
set clipboard^=unnamed
set clipboard^=unnamedplus

" 标签
map tu :tabe<CR>

" 切换标签
map tj :-tabnext<CR>
map tl :+tabnext<CR>

" 分屏
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>

" 分屏后光标移动
map <LEADER>i <C-w>k
map <LEADER>k <C-w>j
map <LEADER>j <C-w>h
map <LEADER>l <C-w>l

" 分屏宽/高度
"map <up> :res +5<CR>
"map <down> :res -5<CR>
"map <left> :vertical resize-5<CR>
"map <right> :vertical resize+5<CR>

" 切换垂直/水平分屏
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

" 将s屏蔽掉（小写s是删除当前字符并插入模式）
map s <nop>
" 大写S 保存文件
map S :w<CR>
" 大写Q 退出
map Q :q<CR>
" 大写R 重新加载vimrc配置文件
map R :source $MYVIMRC<CR>
" ----------------------------------

"syntax enable
" 语法高亮
"syn on
syntax on
"syntax off

" 显示右下角状态栏
"set ruler

" 显示左下角状态栏，--INSERT--之类
"set showmode

" TODO...
set nocompatible

" 文件类型
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" 鼠标支持
set mouse=a

" 某些终端跑vim的时候，优化配色
let &t_ut=''

" tab 操作
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" 自动缩进
"set autoindent

" 显示行尾的空格
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=5

" 缩进相关
set tw=0
set indentexpr=

" TODO... 退格键，行首退到行尾
"set backspace=indent,eol,start

" TODO...
set foldmethod=indent
set foldlevel=99
set laststatus=2
set autochdir

" TODO... 有些终端无效 -  不同模式下，光标样式不一样
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" 保存上一次的光标位置(编辑的位置) - 关闭文件后，重新进入会直接跳转到上一次光标的位置(编辑的位置)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 显示行号
"set nu
set number
" 重定义行号
set relativenumber

" 当前行添加一条线
"set cursorline

" 是否换行
set wrap

" 搜索是否高亮显示
set hlsearch
exec "nohlsearch"

" 边搜索边高亮
set incsearch

" 设置屏幕中间竖条
" set colorcolumn=80,120

" 忽略大小写搜索
set ignorecase
set smartcase

" TODO...
set showcmd

" 输入命令，每输完再按tab建会自动罗列出命令
set wildmenu

" ----------------------------------

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdcommenter'

" Plug 'Dave-Elec/gruvbox'
Plug 'sainnhe/gruvbox-material'

Plug 'drsooch/gruber-darker-vim'

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'fatih/vim-go'
"Plug 'zah/nim.vim'
"Plug 'ding-e/nim-highlight'
"Plug 'ziglang/zig.vim'

call plug#end()
" ----------------------------------

let g:airline_theme='powerlineish'

" 注释的时候自动加个空格
let g:NERDSpaceDelims=1
map <LEADER>/ <LEADER>c<SPACE>

" 禁用gruvbox_material主题注释斜体
let g:gruvbox_material_disable_italic_comment = 1

" 如果不是gui
if !has('gui_running')
  "let g:gruvbox_transparent_bg=1
  let g:gruvbox_material_transparent_background = 1
else
  "set guifont=新宋体:h10
  set guifont=Fixedsys:h10

  " 列数
  set columns=165
  " 行数
  set lines=40

  " 启动时屏幕位置
  winpos 350 170

  " 关闭左右侧滚动条
  set guioptions-=rL

  " 启动时直接最大化窗口
  "au GUIEnter * simalt ~x

endif

" 显示颜色色调- dark, light
set background=dark

"gruvbox GruberDarker
colorscheme gruvbox-material

" 顯示/隱藏 行號
" DeLineNumber    -> 顯示行號
" DeLineNumber 0  -> 刪除行號
command! -nargs=* DeLineNumber call s:DeLineNumber(<q-args>)
function! s:DeLineNumber(args) abort
  if "" != a:args
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunction


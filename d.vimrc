" vim与fzf 配合使用
set rtp+=/opt/homebrew/opt/fzf

" 编码为utf8
set encoding=utf-8

" 取消搜索的高亮
let mapleader=" "
noremap <LEADER><CR> :nohlsearch<CR>
" 搜索结果光标移动并到屏幕中心
noremap = nzz
noremap - Nzz

" jj 映射 esc
inoremap jj <esc>

" 快速移動
"noremap [ 5i
"noremap ] 5k
"noremap { 7i
"noremap } 7k

" vim剪切板与系统共享
"set clipboard+=unnamedplus
set clipboard^=unnamed
set clipboard^=unnamedplus

" buffer
map <TAB> :bn<CR>
map <S-TAB> :bp<CR>
map <LEADER>x :bdel<CR>

" 标签
map tu :tabe<CR>

" 切换标签
map th :-tabnext<CR>
map tl :+tabnext<CR>

" 分屏
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

" 分屏焦點切換
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-h> <C-w>h
map <C-l> <C-w>l

" 分屏宽/高
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" 切换垂直/水平分屏
map su <C-w>t<C-w>H
map si <C-w>t<C-w>K

" 屏蔽s（s: 删除当前字符并插入模式）
map s <nop>

map S :w<CR>
map Q :q<CR>

" 重新加载vimrc
map R :source $MYVIMRC<CR>
" ----------------------------------

" 语法高亮
"syntax enable
"syn on
syntax on

" 右下角状态栏
"set ruler

" 左下角状态栏，--INSERT--之类
"set showmode

" 无需兼容vi
set nocompatible

" 文件类型
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" 鼠标支持
set mouse=a

" tab 操作
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" 自动缩进
"set autoindent

" 突出行尾空格
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=5

" 缩进相关
set tw=0
set indentexpr=

" 退格键，能从当前行首退到上一行行尾
"set backspace=indent,eol,start

" 折叠
set foldmethod=indent
set foldlevel=99
set laststatus=2
set autochdir

" 保存上一次的光标位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 显示行号
set number
set relativenumber

" 自動换行
set wrap

" 突出當前行
"set cursorline

" 突出某一列(行字符數提示)
set colorcolumn=80,120

" 高亮搜索結果
set hlsearch

" 边搜索边高亮
set incsearch

" 忽略大小写搜索
set ignorecase
set smartcase

" 右下角显示当前输入的命令
set showcmd

" 命令行补全
set wildmenu

" ----------------------------------

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'

Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdcommenter'
Plug 'rhysd/accelerated-jk'

" Plug 'Dave-Elec/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'drsooch/gruber-darker-vim'

"Plug 'fatih/vim-go'
"Plug 'zah/nim.vim'
"Plug 'ding-e/nim-highlight'
"Plug 'ziglang/zig.vim'

call plug#end()
" ----------------------------------

" 加速jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" 注释的时候自动加个空格
let g:NERDSpaceDelims=1
map <LEADER>/ <LEADER>c<SPACE>

" bufferline
let g:bufferline_echo=0
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'

" status line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '>'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_z = airline#section#create_right(['L:%l C:%c P:%P'])

" tree
let g:NERDTreeDirArrowExpandable = ' +'
let g:NERDTreeDirArrowCollapsible = ' -'
nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif



" ---------------------------------------------------------



" 禁用gruvbox_material主题注释斜体
let g:gruvbox_material_disable_italic_comment = 1

if !has('gui_running')
  "let g:gruvbox_transparent_bg=1
  let g:gruvbox_material_transparent_background = 1
else
  "set guifont=新宋体:h10
  set guifont=Fixedsys:h10

  " 行列
  set columns=165
  set lines=40

  " 启动时屏幕位置
  winpos 350 170

  " 关闭左右侧滚动条
  set guioptions-=rL

  " 启动时直接最大化窗口
  "au GUIEnter * simalt ~x

endif

" dark, light
set background=dark

" gruvbox GruberDarker
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


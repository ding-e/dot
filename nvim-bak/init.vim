if exists('g:vscode')
    " VSCode extension

    " 在 Mac 上，按住h、j和k移动l键时可能不会重复，
    " 以修复此打开的终端并执行以下命令：
    " defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false.
    " 如果editor.scrollBeyondLastLine禁用，扩展程序效果最好。

    " 快速上下左右跳转
    noremap _ 5j
    noremap + 5k
    noremap { 7j
    noremap } 7k

    " 取消搜索的高亮
    let mapleader=" "
    noremap <LEADER><CR> :nohlsearch<CR>
    " 搜索结果光标移动并自动到屏幕中心
    " 注意：zz: 表示自动将光标所在位置移动到屏幕中间
    noremap = nzz
    noremap - Nzz

    " 垂直分屏
    " :sp
    " :sp filename

    " 横式分屏
    " :vsp
    " :vsp file

    " diff 模式打开一个分屏
    " （分屏会随着光标行数移动，分屏也会移动）
    ":diffs filename
    ":diffvs filename

    " https://www.freesion.com/article/2188339723/
    " 所有分屏一样高度与宽度
    " ctrl+w =
    " 增加高度
    " ctrl+w +
    " 减少高度
    " ctrl+w -

    " 分屏后光标移动
    map <LEADER>k <C-w>k
    map <LEADER>j <C-w>j
    map <LEADER>h <C-w>h
    map <LEADER>l <C-w>l

else

    " ordinary neovim

" =========================================
" DINGE.CODING START
" =========================================

" 设置为不考虑和vi兼容
set nocompatible

" 编码为utf8
set encoding=utf-8

" 语法高亮
syntax on

" 文件类型 - 是否检测文件类型
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" vim与fzf 配合使用
" :FZF 命令使用
set rtp+=/opt/homebrew/opt/fzf
" 在终端下使用fzf 使得vim快速找到所需打开的文件
" vim **  , 然后按tab

" vim剪切板与系统共享
set clipboard+=unnamedplus

" TODO... 折叠功能?
set foldmethod=indent
set foldlevel=99
" 永远显示状态栏
set laststatus=2
set autochdir

" 显示右下角状态栏
"set ruler
" 显示左下角状态栏，--INSERT--之类
"set showmode
" 状态栏显示信息
"set statusline=dinge

" 鼠标支持
set mouse=a
" 开启鼠标模式
noremap MO :set mouse=a<CR>
" 关闭鼠标模式
noremap MC :set mouse=<CR>

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

" TODO... 有些终端无效 -  不同模式下，光标样式不一样
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" 保存上一次的光标位置(编辑的位置) - 关闭文件后，重新进入会直接跳转到上一次光标的位置(编辑的位置)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 显示行号
set number

" 重定义行号
set relativenumber

" 当前行高亮 - 添加一条线
"set cursorline

" 是否换行
set wrap

" 搜索是否高亮显示
set hlsearch
exec "nohlsearch"

" 边搜索边高亮
set incsearch

" 忽略大小写搜索
set ignorecase
set smartcase

" TODO...
"set showcmd

" 输入命令，每输完再按tab建会自动罗列出命令
"set wildmenu

" ----------------------------------

" 取消搜索的高亮
let mapleader=" "
noremap <LEADER><CR> :nohlsearch<CR>
" 搜索结果光标移动并自动到屏幕中心
" 注意：zz: 表示自动将光标所在位置移动到屏幕中间
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
noremap _ 5j
noremap + 5k
noremap { 7j
noremap } 7k

" 光标移到当前行首个字符
" 默认是 0 / ^
"noremap <C-n> 0

" 光标移到当前行最后字符
" 默认是 $
"noremap <C-i> $

" ========================
" 缓冲区
" ------------------------
"" 查看缓冲区页列表
"" 或者 :buffers
"map bb :ls<CR>
"" 跳转到某个缓冲区页
"" 或者 :b<N>
"map bn :buffer 
"" ------------------------
"" 跳转到列表的第一个缓冲页
"" 或者 :bf
"map bh :bfirst<CR>
"" 跳转到列表的最后一个缓冲页
"" 或者 :bl
"map bl :blast<CR>
"" ------------------------
"" 跳转到下一个缓冲页
"" 或者 :bn
"map bj :bnext<CR>
"" 跳转到上一个缓冲页
"" 或者 :bp
"map bk :bprev<CR>
"" 跳转到刚刚轮换的缓冲页
"map bs <C-^>
"" ------------------------
"" 删除当前缓冲页
"" 或者 :bd
"map bdt :bdelete<CR>
"" 删除多个缓冲区, :bdelete n1 n2 n3 
"" 或者 :n,m bdelete
"" 或者 :bd<N>
"map bdm :bdelete 
"" ========================

" 标签
map tu :tabe<CR>

" 切换标签
map th :-tabnext<CR>
map tl :+tabnext<CR>

" 关闭标签
" 上/下一个标签
map tch :-tabc<CR>
map tcl :+tabc<CR>
" 关闭其他标签
map tco :tabo<CR>

" TODO 分屏
" 下分屏 - 光标在上
map sj :set nosplitbelow<CR>:split<CR>
" 上分屏 - 光标在下
map sk :set splitbelow<CR>:split<CR>
"
map sh :set splitright<CR>:vsplit<CR> " 右分屏 - 光标在左
map sl :set nosplitright<CR>:vsplit<CR>

" 垂直分屏
" :sp
" :sp filename

" 横式分屏
" :vsp
" :vsp file

" diff 模式打开一个分屏
" （分屏会随着光标行数移动，分屏也会移动）
":diffs filename
":diffvs filename

" https://www.freesion.com/article/2188339723/
" 所有分屏一样高度与宽度
" ctrl+w =
" 增加高度
" ctrl+w +
" 减少高度
" ctrl+w -

" 分屏后光标移动
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l

" 分屏宽/高度
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" 切换垂直/水平分屏
"map sv <C-w>t<C-w>H
"map sh <C-w>t<C-w>K

" 将s屏蔽掉（小写s是删除当前字符并插入模式）
map s <nop>

" 大写S 保存文件
map S :w<CR>
" 大写Q 退出
map Q :q<CR>

" 大写RC 重新加载vimrc配置文件
" (貌似nvim无效，即使手动设置了$MYVIMRC环境变量)
"map RC :source $MYVIMRC<CR>
map RC :source init.vim<CR>
" ----------------------------------


" TODO
" https://github.com/renerocksai/renerocksai.stow/blob/master/nvim/.config/nvim/init.vim


" vim-plug
call plug#begin('~/.config/nvim/plugged')

" 只在neovim下使用
" telescope.nvim、gitsigns.nvim、vgit.nvim、neogit 这些插件依赖此库
Plug 'nvim-lua/plenary.nvim'

" 启动页
Plug 'mhinz/vim-startify'

" 加速jk
Plug 'rhysd/accelerated-jk'

" 主题
" Plug 'Dave-Elec/gruvbox'
Plug 'sainnhe/gruvbox-material'

" 状态栏 / 状态栏主题
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 如果在一个分割中打开了两个缓冲区，
" 并且想要关闭一个缓冲区，那么可以使用:bd命令。
" 不幸的是，这个命令也关闭了分割。
" 通常，不想关闭分割，而只想关闭缓冲区。
" 在这种情况下，使用Buffkill的:BD命令，
" 该命令将关闭缓冲区，但保留分割。
Plug 'qpkorr/vim-bufkill'

" 高亮显示拖动的线条
" 高亮显示yanked内容
"Plug 'machakann/vim-highlightedyank'

" 文件目录查看器 nerd-tree
"Plug 'preservim/nerdtree'

" 文件目录查看器 nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

" 文件查找器
" 该插件依赖nvim-lua/plenary.nvim插件
Plug 'nvim-telescope/telescope.nvim'

" 缓冲区列表
Plug 'bling/vim-bufferline'

" 文件图标
"Plug 'kyazdani42/nvim-web-devicons' " for file icons

" 类大纲查看器
"Plug 'majutsushi/tagbar'

"Plug 'dense-analysis/ale'
"Plug 'mbbill/undotree'

" Plug 'ctrlpvim/ctrlp.vim'

" Git包装器插件
" Plug 'tpope/vim-fugitive'

" nvim workspace - 只要打开vim，就打开保存的工作目录
" 该插件依赖nvim-lua/plenary.nvim插件
"Plug 'Shatur/neovim-session-manager'
" --------------------------
"Plug 'tpope/vim-obsession'
"Plug 'dhruvasagar/vim-prosession'



" coc lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ycm-core/YouCompleteMe'

"" lua and lsp stuff
"Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
"Plug 'nvim-lua/completion-nvim'
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
""Plug 'tjdevries/nlua.nvim'  " TJ's magic stuff

" go语言插件
"Plug 'fatih/vim-go'

" zig语言插件
Plug 'ziglang/zig.vim'

call plug#end()
" ----------------------------------

" airline 状态栏
" --------------------
"let g:airline_theme='powerlineish'
"let g:airline_theme='bubblegum'
"let g:airline_solarized_bg='dark'
" -----------------------------------------------------------

" jk 加速插件
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"nmap j <Plug>(accelerated_jk_gj_position)
"nmap k <Plug>(accelerated_jk_gk_position)
"let g:accelerated_jk_acceleration_limit = 300


" nerd-tree 文件管理器
" --------------------
"" 切换NERDTree
""map <F3> :NERDTreeMirror<CR>
""map <F3> :NERDTreeToggle<CR>
"map TT :NERDTreeMirror<CR>
"map TT :NERDTreeToggle<CR>
"
""  NERDTree打开当前文件所在目录
""map <F2> :exec("NERDTree ".expand('%:h'))<CR>
"map TE :exec("NERDTree ".expand('%:h'))<CR>
" -----------------------------------------------------------

" nvim-tree 文件管理器
" --------------------
nnoremap TT :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tn :NvimTreeFindFile<CR>
nnoremap <leader>tl :NvimTreeCollapse<CR>
nnoremap <leader>tf :NvimTreeFocus<CR>

" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

"set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
"highlight NvimTreeFolderIcon guibg=blue

lua require 'nvim-tree'.setup {}
"lua require 'nvim-tree'.toggle()
" -----------------------------------------------------------


" vim-buffkill - 缓冲区管理增强
" --------------------
"卸载/删除/擦除
"以下所有内容使窗口/拆分保持不变：
":BUN - 从缓冲区中卸载文件
":BD  - 从缓冲区中删除文件
":BW  - 从缓冲区中擦除文件
"注意键映射是:bun :bd :bwVim 命令的大写版本吗？简单的！
"
"通过缓冲区移动
":BB  - 向后移动最近访问的缓冲区
":BF  - 通过最近访问的缓冲区向前移动
":BA  - 移动到备用缓冲区并将光标保持在同一列中

" Turn off default <leader>bb, <leader>bd, etc. mappings (default: 1)
let g:BufKillCreateMappings = 1

" Override default <C-^> behavior for swapping between alternate buffers (default: 0)
"let g:BufKillOverrideCtrlCaret = 1

" Modify the command prefix if it conflicts with other plugins
" The below changes BD to DD, BB to DB, etc. (default: 'B')
"let g:BufKillCommandPrefix = 'D'

" If the buffer you want to kill is in many windows, the following option governs what to do (default: 'confirm', options: 'confirm'/'kill'/'cancel')
"let g:BufKillActionWhenBufferDisplayedInAnotherWindow = 'kill'
" -----------------------------------------------------------


" nvim-telescope - 文件查找器
" --------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>

lua require 'telescope'.setup{}
" -----------------------------------------------------------


" coc - lsp 语言服务器引擎
" --------------------
let g:coc_global_extensions = [
    \ 'coc-marketplace',
    \ 'coc-vimlsp' ]
" -----------------------------------------------------------


" nvim workspace - 只要打开vim，就打开保存的工作目录
" 该插件依赖nvim-lua/plenary.nvim插件
" --------------------
"lua << EOF
"local Path = require('plenary').path
"require('session_manager').setup({
"  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
"  path_replacer = '__', -- The character to which the path separator will be replaced for session files.
"  colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
"  autoload_mode = require('session_manager.config').AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
"  --autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
"  autosave_last_session = true, -- Automatically save last session on exit and on session switch.
"  autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
"  autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
"    'gitcommit',
"  }, 
"  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
"  max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
"})
"EOF
"
"augroup _open_nvim_tree
"    autocmd! * <buffer>
"    autocmd SessionLoadPost * silent! lua require 'nvim-tree'.toggle(false, true)
"augroup end
" -----------------------------------------------------------

"let g:prosession_dir = '~/.config/nvim/session'


" gruvbox-material 主题
" --------------------
" 禁用gruvbox_material主题注释斜体
let g:gruvbox_material_disable_italic_comment = 1

"" 如果不是gui
"if !has('gui_running')
"  "let g:gruvbox_transparent_bg=1
"  let g:gruvbox_material_transparent_background = 1
"else
"  "set guifont=FixedsysTTF\ Monospaced:h10
"  "set guifont=FixedsysTTF:h11
"  "set guifont=FixedsysTTF
"  "set guifont=新宋体:h10
"  set guifont=Fixedsys:h10
"
"  " 列数
"  set columns=165
"  " 行数
"  set lines=40
"
"  " 启动时屏幕位置
"  winpos 350 170
"
"  " 关闭左右侧滚动条
"  set guioptions-=rL
"
"  " 启动时直接最大化窗口
"  "au GUIEnter * simalt ~x
"
"endif
" -----------------------------------------------------------

" 显示颜色色调
set background=dark
"set background=light

"colorscheme gruvbox
colorscheme gruvbox-material










" ===========================================
"  - vim的几种模式和按键映射:
"    https://mounui.com/295.html
" -------------------------------------------
"  - inoremap: 插入/编辑insert模式下生效
"  - vnoremap: 可视/选择visual模式下生效
"  - nnoremap: 默认/普通normal模式下生效
"  - cnoremap: 命令模式下生效(vim最底一行)
" -------------------------------------------


" ===========================================
"  - i / I : 在光标前面 / 行首插入
"  - a / A : 在光标后面 / 行尾插入
"  - o / O : 在下 / 上一行行首插入
"  - cw : 删除当前光标位置到标点符位置的字符串
"  - cW : 删除当前光标位置到后面第一个空格位置
" -------------------------------------------
"  - w     : 移动光标到下一个单词的词首
"  - e     : 移动光标到下一个单词的结尾
"  - b     : 移动光标到上一个单词的词首
"  - ge    : 移动光标到上一个单词的结尾
"  - ^ / $ : 行首 / 行尾
" -------------------------------------------
"  - v     : 小v 左右选择当个字符，上下选择行
"  - V     : 大V 上下选择整行
"  - <C-v> : ctrl+v 纵横块 选择
" -------------------------------------------
"  - u     : 撤销上一步操作
"  - <C-r> : 恢复上一步被撤回的操作
" -------------------------------------------
"  - <C-a>   : ctrl + a
"  - <A-a>   : alt  + a
"  - <C-A-a> : ctrl + alt + a
"  - <C-A-A> : ctrl + alt + shift + a
" ===========================================



endif

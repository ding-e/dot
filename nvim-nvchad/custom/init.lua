------------------------------------
-- 全局配置
-------------
---@diagnostic disable: lowercase-global, undefined-global

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

require "custom.autocmd"
require "custom.command"

-- 打开文件返回上次修改的位置
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

-- :FZF 命令使用
-- vim.cmd [[ set rtp+=/opt/homebrew/opt/fzf ]]

-- 設置默認shell
vim.cmd [[ set shell=zsh ]]

-- vim剪切板与系统共享
vim.cmd [[ set clipboard+=unnamedplus ]]

-- 相对行号
vim.cmd [[ set relativenumber ]]

-- 是否换行
vim.cmd [[ set wrap ]]

-- 设置在某一行里使用hl移动至行尾/首，不自动跳转到上/下一行
-- 【nvchad 默认是自动跳转】
vim.cmd [[ set whichwrap=b,s ]]

-- 设置屏幕中间竖条
vim.cmd [[ set colorcolumn=80,120 ]]

-- tab 操作
-- vim.cmd [[
--    set expandtab
--    set tabstop=4
--    set shiftwidth=4
--    set softtabstop=4
-- ]]

-- 折叠
vim.cmd [[
   " 禁止折叠
   set nofoldenable
   " set foldmethod=manual
]]

-- 显示行尾的空格
vim.cmd [[
   set list
   " set listchars=tab:\|\ ,trail:▫,space:⋅,eol:↴
   set listchars=trail:▫
]]

-- 设置行数中（错误/警告等）代码检查宽度
-- vim.cmd [[ set signcolumn=yes:2 ]]

vim.cmd [[ set scrolloff=5 ]]

-- 关闭文件后，不保存之前的撤回与撤销功能
vim.cmd [[ set noundofile ]]

-- nvim-tree
vim.cmd [[ hi! link NvimTreeExecFile NONE ]]

-- search
-- vim.cmd [[
--    " k边搜索边高亮
--    set incsearch
--    " 忽略大小写搜索
--    set ignorecase
--    set smartcase
-- ]]

-- 退出终端模式
-- 在nvcard->core->mappings.lua 下，已经设置了ctrl+x退出终端模式
-- vim.cmd [[ tnoremap <C-q> <C-\><C-n> ]]




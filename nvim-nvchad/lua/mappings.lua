------------------------------------
-- 自定義快捷鍵
-------------------
---@diagnostic disable: lowercase-global, undefined-global

require "nvchad.mappings"

local config = require "configs.config"
local utils = require "utils.func"

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-----------------
-- sendCommand
-----------------
-- map("n", "<leader>cc", function ()
--    require("nvchad.term").show "vertical"
--    require("nvchad.term").hide "vertical"
--    require("nvchad.term").send("clear && g++ -o out " .. vim.fn.expand "%" .. " && ./out", "vertical")
-- end, "compile & run a cpp file")

-----------------
-- general
-----------------
map("t", "WW", "<CMD> q <CR>")

map("i", "jj", "<ESC>", { desc = "escape normal mode" })
map("n", "s", "<nop>", { desc = "禁用s按键" })
map("n", "S", "<CMD> w <CR>", { desc = "保存文件" })
map("n", "<leader>cb", function()
   require("nvchad.tabufline").closeAllBufs()
end, { desc = "关闭所有buffer" })
map("n", "Q", function()
   -- 獲取當前有多少個分屏
   -- print(vim.fn.winnr("$"))
   -- 查看nvimtree是否已打開
   -- print(require("nvim-tree.view").is_visible())
   -- 查看undotree是否已打開
   -- echo call undotree#UndotreeIsVisible()
   -- lua print(vim.fn['undotree#UndotreeIsVisible']())

   if string.find(vim.fn.expand "%", "term://") then
      vim.cmd [[ bd! ]]
      return
   end

   local tree_isopen = require("nvim-tree.view").is_visible() == true
   local undo_isopen = vim.fn["undotree#UndotreeIsVisible"]() == 1
   local curr_is_tree = vim.fn.expand "%" == "NvimTree_1"
   local curr_is_undo = vim.fn.expand "%" == "undotree_2"
   local curr_is_diff = vim.fn.expand "%" == "diffpanel_3"

   -- TODO...
   if curr_is_tree then
      vim.cmd [[ NvimTreeClose ]]
   elseif curr_is_undo or curr_is_diff then
      vim.cmd [[ UndotreeHide ]]
   elseif not curr_is_tree and not curr_is_undo and not curr_is_diff then
      if tree_isopen and vim.fn.winnr "$" < 3 then
         vim.cmd [[ NvimTreeClose ]]
      end
      if undo_isopen and vim.fn.winnr "$" < 4 then
         vim.cmd [[ UndotreeHide ]]
      end
      if tree_isopen and undo_isopen and vim.fn.winnr "$" < 5 then
         vim.cmd [[ NvimTreeClose ]]
         vim.cmd [[ UndotreeHide ]]
      end
      vim.cmd [[ q ]]
   end
end, { desc = "保存文件" })

-- 开启/关闭鼠标模式
map("n", "MO", "<CMD> set mouse=a <CR>", { desc = "" })
map("n", "MC", "<CMD> set mouse= <CR>", { desc = "" })

map("n", "<leader><CR>", "<CMD> nohlsearch <CR>", { desc = "取消搜索高亮" })
map("n", "<Esc>", "<CMD> noh <CR>", { desc = "clear highlights" })

-- 移动搜索结果关键字并自动移到屏幕中心
map("n", "=", "nzz", { desc = "" })
map("n", "-", "Nzz", { desc = "" })

-- 快速上下跳转
map("n", "_", "5j", { desc = "" })
map("n", "+", "5k", { desc = "" })
map("n", "{", "7j", { desc = "" })
map("n", "}", "7k", { desc = "" })

-- 标签
map("n", "ta", "<cmd> tabe <CR>", { desc = "添加一个标签" })
-- 切换标签
-- map("n", "th", "<CMD> -tabnext <CR>", {desc = "" })
-- map("n", "tl", "<CMD> +tabnext <CR>", {desc = "" })
map("n", "th", "<CMD> tabprevious <CR>", { desc = "跳转上一个标签" })
map("n", "tl", "<CMD> tabnext <CR>", { desc = "跳转下一个标签" })
map("n", "tc", "<CMD> tabc <CR>", { desc = "关闭当前标签" })
map("n", "to", "<CMD> tabo <CR>", { desc = "关闭其他标签" })

-- 快速分屏
map("n", "sj", "<CMD> split <CR>", { desc = "" })
map("n", "sl", "<cmd> vsplit <CR>", { desc = "" })

-- 调整分屏大小
map("n", "<Up>", "<CMD> res +5 <CR>", { desc = "" })
map("n", "<Down>", "<CMD> res -5 <CR>", { desc = "" })
map("n", "<Left>", "<CMD> vertical resize -5 <CR>", { desc = "" })
map("n", "<Right>", "<CMD> vertical resize +5 <CR>", { desc = "" })

-- 打开当前文件目录
map(
   "n",
   "<leader>po",
   "<CMD>lua os.execute('" .. utils.get_filemanager_cmd() .. " ' .. vim.fn.expand('%:p:h') .. ' 2>/dev/null') <CR>",
   { desc = "打开当前文件目录" }
)
-- CTRL+g
map("n", "<leader>pc", "<CMD>echo expand('%:p') <CR>", { desc = "查看当前文件路徑" })

-----------------
-- lspconfig
-----------------
-- 重写nvchad lsp快捷键
local diagnostic_opts = {
   -- focusable = false,
   -- close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
   -- border = "rounded", source = "always", prefix = " ", scope = "cursor",

   border = "rounded",
   scope = "line",
}

-- LSP
map("n", "<leader>lps", "<CMD> LspStart <CR>", { desc = "啟動LSP服務" })
map("n", "<leader>lpr", "<CMD> LspRestart <CR>", { desc = "重啟LSP服務" })
map("n", "<leader>lpk", "<CMD> LspStop <CR>", { desc = "關閉LSP服務" })

map("n", "K", function()
   vim.lsp.buf.hover()
end, { desc = "顯示數據結構信息 - lsp hover" })

map("n", "<leader>e", function()
   vim.diagnostic.open_float(nil, diagnostic_opts)
end, { desc = "浮動顯示錯誤信息 - floating diagnostic" })

map("n", "[d", function()
   vim.diagnostic.goto_prev { float = diagnostic_opts }
end, { desc = "跳轉到上一個錯誤 - goto prev" })

-- 原: d]
map("n", "]d", function()
   vim.diagnostic.goto_next { float = diagnostic_opts }
end, { desc = "跳轉到下一個錯誤 - goto_next" })

map("n", "<leader>q", function()
   vim.diagnostic.setloclist()
end, { desc = "底部顯示錯誤列表 - diagnostic setloclist" })

map("n", "gD", function()
   vim.lsp.buf.declaration()
end, { desc = "跳轉到聲明 - lsp declaration" })

map("n", "gd", function()
   vim.lsp.buf.definition()
end, { desc = "跳轉到定義 - lsp definition" })

map("n", "gi", function()
   vim.lsp.buf.implementation()
end, { desc = "跳轉到實現 - lsp implementation" })

map("n", "gr", function()
   vim.lsp.buf.references()
end, { desc = "跳轉到參考 - lsp references" })

map("n", "<leader>ra", function()
   require("nvchad.renamer").open()
end, { desc = "修改名稱 - lsp rename" })

-----------------
-- plugin
-----------------

-- 打开仪表盘
-- mhinz/vim-startify
map("n", "DD", "<CMD> Startify <CR>", { desc = "" })
map("n", "<leader>ss", "<CMD> Startify <CR>", { desc = "打开startify仪表盘" })

-- FZF
-- map("n", "<leader>fz", "<CMD> FZF <CR>", {desc = "fzf文件搜索"})

-- 切换文件管理器
-- kyazdani42/nvim-tree.lua
map("n", "TT", "<CMD> NvimTreeToggle <CR>", { desc = "切换nvimtree" })
map("n", "<leader>tf", "<CMD> NvimTreeFocus <CR>", { desc = "焦点在nvim-tree" })
map("n", "<leader>tr", "<CMD> NvimTreeRefresh <CR>", { desc = "刷新nvim-tree列表" })
map("n", "<leader>tn", "<CMD> NvimTreeFindFile <CR>", { desc = "定位文件所在nvim-tree位置" })
map("n", "<leader>tl", "<CMD> NvimTreeCollapse <CR>", { desc = "折叠所有层级" })

-- 歷史編輯管理器
-- mbbill/undotree
map("n", "<leader>ud", "<CMD> UndotreeToggle <CR>", { desc = "切换undo-tree" })

-- Gitsigns
-- lewis6991/gitsigns.nvim
map("n", "<leader>gf", "<CMD> Gitsigns diffthis <CR>", { desc = "對比當前文件" })
map("n", "<leader>gd", "<CMD> Gitsigns toggle_deleted <CR>", { desc = "最近已刪除的代碼" })

-- jk加速
-- rhysd/accelerated-jk
map("n", "j", "<Plug>(accelerated_jk_gj)", { desc = "" })
map("n", "k", "<Plug>(accelerated_jk_gk)", { desc = "" })
-- map("n", "j", "<Plug>(accelerated_jk_gj_position)", {desc = ""})
-- map("n", "k", "<Plug>(accelerated_jk_gk_position)", {desc = ""})

-- 符號對齊插件
-- junegunn/vim-easy-align
-- 選段對齊冒號 vipga`->`:
-- 選段對齊等號 vipga`->`=
map("n", "ga", "<Plug>(EasyAlign)", { desc = "" })

-- 切换主题
map("n", "<leader>tt", function()
   require("base46").toggle_theme()
end, { desc = "切换主题" })

-- 選擇模式
-- 符號對齊插件
-- junegunn/vim-easy-align
-- 選列對齊冒號 ga`->`:
-- 選列對齊等號 ga`->`=
-- 選列上下對齊所有行列空格 ga*`space`
map("x", "ga", "<Plug>(EasyAlign)", { desc = "" })

-- session
-- folke/persistence.nvim
map("n", "<leader>sd", function()
   local buf_list_len = vim.fn.len(vim.fn.getbufinfo { buflisted = 1 })
   if
      (buf_list_len == 0)
      or (buf_list_len == 1 and (vim.api.nvim_buf_get_name(0) == "" or vim.api.nvim_buf_line_count(0) == 1))
   then
      require("nvchad.tabufline").close_buffer()
   end
   -- if buf_list_len == 0 then require("nvchad.tabufline").close_buffer() end
   require("persistence").load()
   -- require("nvim-tree").toggle(false, true)
end, { desc = "session: 恢复当前目录的会话" })

map(
   "n",
   "<leader>sl",
   "<CMD> lua require('persistence').load({ last = true }) <CR>",
   { desc = "session: 恢复上次会话" }
)
map(
   "n",
   "<leader>sc",
   "<CMD> lua require('persistence').stop() <CR>",
   { desc = "session: 退出时不会保存会话" }
)

-- zen
-- Pocco81/truezen.nvim
map("n", "<leader>zz", "<CMD> ZenMode <CR>", { desc = "禪模式 (zen-mode)" })
map("n", "<leader>zi", function()
   require("zen-mode").toggle { window = { width = 88 } }
end, { desc = "禪模式: width = 88 (zen-mode)" })
map("n", "<leader>ze", function()
   require("zen-mode").toggle { window = { width = 0.85 } }
end, { desc = "禪模式: width = 85% (zen-mode)" })
map("n", "<leader>zo", function()
   require("zen-mode").toggle { window = { width = 0.5 } }
end, { desc = "禪模式: width = 50% (zen-mode)" })
map("n", "<leader>za", "<CMD> TZAtaraxis <CR>", { desc = "禪模式 (truezen)" })
map("n", "<leader>zf", "<CMD> TZFocus <CR>", { desc = "當有分屏時全屏" })
map("n", "<leader>zm", "<CMD> TZMinimalist <CR>", { desc = "隱藏行號/狀態欄/標籤列" })
map("n", "<leader>zn", "<CMD> TZNarrow <CR>", { desc = "禪模式-打開當前行" })

map("x", "<leader>zn", ":'<,'>TZNarrow <CR>", { desc = "禪模式-打開所選行" })

-----------------
-- terminal
-----------------
-- 重置切换终端快捷键映射

-- 在nvchad里，ctrl+x 终端模式退到终端默认模式
-- ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" },
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
-- map("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "escape terminal mode" })
map("t", "AA", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "escape terminal mode" })

-- new terminals
map("n", "<leader>ht", function()
   require("nvchad.term").new { pos = "sp" }
end, { desc = "   新建水平終端" })

map("n", "<leader>vt", function()
   require("nvchad.term").new { pos = "vsp" }
end, { desc = "   新建垂直終端" })
map("n", "<leader>st", function()
   vim.cmd [[ DeTerm ]]
end, { desc = "   新建全屏終端" })

-- toggleable
map({ "n", "t" }, "<C-v><C-k>", function()
   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "   切換右側終端" })

map({ "n", "t" }, "<C-c><C-k>", function()
   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "   切換底部終端" })

map({ "n", "t" }, "<C-j><C-k>", function()
   require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "   切換浮動終端" })

-- lang
map("n", "<leader>kn", function()
   os.execute "killall nimsuggest"
end, { desc = "kill掉所有nimsuggest进程" })

-----------------
-- game
-----------------
-- map("n", "<leader>gl", "<CMD> GodotRunLast <CR>", {desc = "Godot-运行最后一个场景"})
-- map("n", "<leader>gr", "<CMD> GodotRun <CR>", {desc = "Godot-运行特定场景/主场景"})
-- map("n", "<leader>gc", "<CMD> GodotRunCurrent <CR>", {desc = "Godot-运行当前场景"})
-- map("n", "<leader>gz", "<CMD> GodotRunFZF <CR>", {desc = "Godot-FZF查找并运行场景"})
-- map("n", "<leader>gr", "<CMD> !godot <CR>", {desc = "Godot-运行特定场景/主场景"})
map("n", "<leader>gr", function()
   -- TODO...
   -- local cmd, c, f = "", "", nil
   -- for _, v in pairs(config.project_cmd_list) do
   --    f = io.open(v[1], "r")
   --    if nil ~= f then
   --       c = f:read "*a"
   --       f:close()
   --       cmd = "" ~= v[2] and (nil ~= string.find(c, v[2]) and v[3] or "") or v[3]
   --       break
   --    end
   -- end
   -- if "" ~= cmd then
   --    local nvterm = require "nvterm.terminal"
   --    local type = config.project_term_type
   --    local terms, last_type_term = nvterm.list_terms(), nil
   --    for _, v in pairs(terms) do
   --       if v.type == type then
   --          last_type_term = v
   --       end
   --    end
   --    if nil ~= last_type_term and not last_type_term.open then
   --       nvterm.show_term(last_type_term)
   --    end
   --    -- nvterm.close_all_terms()
   --    nvterm.send(cmd, type)
   -- end
end, { desc = "运行游戏项目" })

--  ========================
--  缓冲区
--  ------------------------
-- " 查看缓冲区页列表
-- " 或者 :buffers
-- map bb :ls<CR>
-- " 跳转到某个缓冲区页
-- " 或者 :b<N>
-- map bn :buffer
-- " ------------------------
-- " 跳转到列表的第一个缓冲页
-- " 或者 :bf
-- map bh :bfirst<CR>
-- " 跳转到列表的最后一个缓冲页
-- " 或者 :bl
-- map bl :blast<CR>
-- " ------------------------
-- " 跳转到下一个缓冲页
-- " 或者 :bn
-- map bj :bnext<CR>
-- " 跳转到上一个缓冲页
-- " 或者 :bp
-- map bk :bprev<CR>
-- " 跳转到刚刚轮换的缓冲页
-- map bs <C-^>
-- " ------------------------
-- " 删除当前缓冲页
-- " 或者 :bd
-- map bdt :bdelete<CR>
-- " 删除多个缓冲区, :bdelete n1 n2 n3
-- " 或者 :n,m bdelete
-- " 或者 :bd<N>
-- map bdm :bdelete
-- " ========================

--  ========================
--  分屏
--  ------------------------
--  垂直分屏
--  :sp
--  :sp filename
--  横式分屏
--  :vsp
--  :vsp file
--  diff 模式打开一个分屏
--  （分屏会随着光标行数移动，分屏也会移动）
--  :diffs filename
--  :diffvs filename
--  https://www.freesion.com/article/2188339723/
--  所有分屏一样高度与宽度
--  ctrl+w =
--  增加高度
--  ctrl+w +
--  减少高度
--  ctrl+w -

-------------------------------------------------------
-- vim 原生快捷键说明
-- =====================

-- 括号快速定位
-- %

-- 标记: 在当前行设置一个标记，然后在其他行编写后，
--       可以跳转到之前设置标记处继续编写
--       (如果编辑一个大文件的时候比较实用)
-- m+l         - 设置标志    : 注意这个l是自定义的
-- `+l         - 回到标记处  : 注意这个l是自定义的
-- :delmarks l - 删除标记    : 注意这个l是自定义的
-- :marks      - 显示所有设置的标志列表

-- 快速调整数字增/减
-- ctrl+a / ctrl+x

-- 快速调整单词的大小写
-- gUw / guw

-- 快速修复拼写错误的单词
-- z+=
-------------------------------------------------------

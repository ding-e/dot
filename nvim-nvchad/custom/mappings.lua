------------------------------------
-- 自定義快捷鍵
-------------------

local M = {}

-- M.disabled = {
--    n = {
--       ["<leader>h"] = "",
--    },
-- }

M.general = {
   t = {
      -- ["<Esc>"] = { "<cmd> q <CR>", "" },
      ["Q"] = { "<cmd> q <CR>", "" },

      -- 在nvchad里，ctrl+x 终端模式退到终端默认模式
      -- ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" },
      ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
   },

   i = {
      ["jj"] = { "<ESC>", "escape normal mode" },
   },

   n = {

      -- 禁用s按键
      ["s"] = { "<nop>", "" },

      -- 【无效】 - 删除当前文件所有行为的空格或tab
      -- ["ds"] = { "<cmd> %s/\s\+$ <CR>", "" },

      -- 保存/关闭文件
      ["S"] = { "<cmd> w <CR>", "" },
      ["Q"] = { "<cmd> q <CR>", "" },
      -- 开启/关闭鼠标模式
      ["MO"] = { "<cmd> set mouse=a <CR>", "" },
      ["MC"] = { "<cmd> set mouse= <CR>", "" },

      -- 取消搜索高亮
      ["<leader><CR>"] = { "<cmd> nohlsearch <CR>", "取消搜索高亮" },

      -- 移动搜索结果关键字并自动移到屏幕中心
      ["="] = { "nzz", "" },
      ["-"] = { "Nzz", "" },

      -- 快速上下跳转
      ["_"] = { "5j", "" },
      ["+"] = { "5k", "" },
      ["{"] = { "7j", "" },
      ["}"] = { "7k", "" },

      -- 标签
      ["ta"] = { "<cmd> tabe <CR>", "" },
      -- 切换标签
      -- ["th"]  = { "<cmd> -tabnext <CR>", "" },
      -- ["tl"]  = { "<cmd> +tabnext <CR>", "" },
      ["th"] = { "<cmd> tabprevious <CR>", "" },
      ["tl"] = { "<cmd> tabnext <CR>", "" },
      -- 关闭其他标签
      ["to"] = { "<cmd> tabo <CR>", "" },

      -- 快速分屏
      ["sj"] = { "<cmd> split <CR>", "" },
      ["sl"] = { "<cmd> vsplit <CR>", "" },

      -- 调整分屏大小
      ["<up>"] = { "<cmd> res +5 <CR>", "" },
      ["<down>"] = { "<cmd> res -5 <CR>", "" },
      ["<left>"] = { "<cmd> vertical resize -5 <CR>", "" },
      ["<right>"] = { "<cmd> vertical resize +5 <CR>", "" },

      -- 打开仪表盘
      -- mhinz/vim-startify
      ["DD"] = { "<cmd> Startify <CR>", "" },
      ["<leader>ss"] = { "<cmd> Startify <CR>", "打开startify仪表盘" },

      -- 切换文件管理器
      -- kyazdani42/nvim-tree.lua
      ["TT"] = { "<cmd> NvimTreeToggle <CR>", "切换nvimtree", opts = {} },
      ["<leader>tf"] = { "<cmd> NvimTreeFocus <CR>", "焦点在nvim-tree" },
      ["<leader>tr"] = { "<cmd> NvimTreeRefresh <CR>", "刷新nvim-tree列表" },
      ["<leader>tn"] = { "<cmd> NvimTreeFindFile <CR>", "定位文件所在nvim-tree位置" },
      ["<leader>tl"] = { "<cmd> NvimTreeCollapse <CR>", "折叠所有层级" },

      -- jk加速
      -- rhysd/accelerated-jk
      ["j"] = { "<Plug>(accelerated_jk_gj)", "" },
      ["k"] = { "<Plug>(accelerated_jk_gk)", "" },
      -- ["j"] = { "<Plug>(accelerated_jk_gj_position)", "" },
      -- ["k"] = { "<Plug>(accelerated_jk_gk_position)", "" },

      -- 符號對齊插件
      -- junegunn/vim-easy-align
      -- 選段對齊冒號 vipga`->`:
      -- 選段對齊等號 vipga`->`=
      ["ga"] = { "<Plug>(EasyAlign)", "" },
   },

   -- 選擇模式
   x = {
      -- 符號對齊插件
      -- junegunn/vim-easy-align
      -- 選列對齊冒號 ga`->`:
      -- 選列對齊等號 ga`->`=
      -- 選列上下對齊所有行列空格 ga*`space`
      ["ga"] = { "<Plug>(EasyAlign)", "" },
   },
}

-- Pocco81/truezen.nvim
M.zen = {
   n = {
      -- ["<leader>za"] = { "<cmd> TZAtaraxis <CR>", "禪模式" },
      ["<leader>zz"] = { "<cmd> ZenMode <CR>", "禪模式" },
      ["<leader>ze"] = {
         function() require("zen-mode").toggle { window = { width = 0.85, }, } end,
         "禪模式: width = 85%"
      },
      ["<leader>zi"] = {
         function() require("zen-mode").toggle { window = { width = 0.5, }, } end,
         "禪模式: width = 50%"
      },

      ["<leader>zn"] = { "<cmd> TZNarrow <CR>", "禪模式-打開當前行" },

      ["<leader>zf"] = { "<cmd> TZFocus <CR>", "當有分屏時全屏" },
      ["<leader>zm"] = { "<cmd> TZMinimalist <CR>", "隱藏行號/狀態欄/標籤列" },
   },
   x = {
      ["<leader>zn"] = { ":'<,'>TZNarrow <CR>", "禪模式-打開所選行" },
   },
}

-- 重置切换终端快捷键映射
M.nvterm = {
   t = {
      -- 禁用ctrl+i按键
      -- ["<C-i>"] = { "<nop>", "" },

      ["<C-j><C-i>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   切換浮動終端",
      },

      ["<C-h><C-i>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   切換底部終端",
      },

      ["<C-v><C-i>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   切換右側終端",
      },
   },

   n = {
      -- 禁用ctrl+i按键
      ["<C-i>"] = { "<nop>", "" },

      ["<C-j><C-i>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   切換浮動終端",
      },

      ["<C-h><C-i>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   切換底部終端",
      },

      ["<C-v><C-i>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   切換右側終端",
      },

      -- new
      ["<leader>h"] = {
         function()
            require("nvterm.terminal").new "horizontal"
         end,
         "   新建水平終端",
      },

      ["<leader>v"] = {
         function()
            require("nvterm.terminal").new "vertical"
         end,
         "   新建垂直終端",
      },

      ["<leader>st"] = {
         function()
            vim.cmd [[ DeTerm ]]
         end,
         "   新建全屏終端",
      },
   },
}

return M

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

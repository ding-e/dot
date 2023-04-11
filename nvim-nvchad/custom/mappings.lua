------------------------------------
-- 自定義快捷鍵
-------------------
---@diagnostic disable: lowercase-global, undefined-global

local config = require "custom.config"
local M = {}

-- M.disabled = {
--    n = {
--       ["<leader>h"] = "",
--    },
-- }

M.sendCommand = {
   n = {
      -- ["<leader>cc"] = {
      --    function()
      -- require("nvterm.terminal").show "vertical"
      -- require("nvterm.terminal").hide "vertical"
      --       require("nvterm.terminal").send("clear && g++ -o out " .. vim.fn.expand "%" .. " && ./out", "vertical")
      --    end,
      --    "compile & run a cpp file",
      -- },
   },
}

M.general = {
   t = {
      -- ["<Esc>"] = { "<cmd> q <CR>", "" },
      ["WW"] = { "<CMD> q <CR>", "" },

      -- 在nvchad里，ctrl+x 终端模式退到终端默认模式
      -- ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" },
      ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
      ["AA"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
   },

   i = {
      ["jj"] = { "<ESC>", "escape normal mode" },
   },

   n = {
      -- 命令行模式
      -- [";"] = { ":", "command mode", opts = { nowait = true } },

      -- 禁用s按键
      ["s"] = { "<nop>", "" },

      -- 【无效】 - 删除当前文件所有行为的空格或tab
      -- ["ds"] = { "<cmd> %s/\s\+$ <CR>", "" },

      -- 保存/关闭文件
      ["S"] = { "<CMD> w <CR>", "" },
      ["Q"] = {
         function()
            -- 獲取當前有多少個分屏
            -- print(vim.fn.winnr("$"))
            -- 查看nvimtree是否已打開
            -- print(require("nvim-tree.view").is_visible())
            -- 查看undotree是否已打開
            -- echo call undotree#UndotreeIsVisible()
            -- lua print(vim.fn['undotree#UndotreeIsVisible']())

            local tree_isopen = require("nvim-tree.view").is_visible() == true
            local undo_isopen = vim.fn["undotree#UndotreeIsVisible"]() == 1
            local curr_is_tree = vim.fn.expand "%" == "NvimTree_1"
            local curr_is_undo = vim.fn.expand "%" == "undotree_2"
            local curr_is_diff = vim.fn.expand "%" == "diffpanel_3"

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
         end,
         "",
      },

      -- 开启/关闭鼠标模式
      ["MO"] = { "<CMD> set mouse=a <CR>", "" },
      ["MC"] = { "<CMD> set mouse= <CR>", "" },

      -- 取消搜索高亮
      ["<leader><CR>"] = { "<CMD> nohlsearch <CR>", "取消搜索高亮" },

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
      -- ["th"]  = { "<CMD> -tabnext <CR>", "" },
      -- ["tl"]  = { "<CMD> +tabnext <CR>", "" },
      ["th"] = { "<CMD> tabprevious <CR>", "" },
      ["tl"] = { "<CMD> tabnext <CR>", "" },
      -- 关闭其他标签
      ["to"] = { "<CMD> tabo <CR>", "" },

      -- 快速分屏
      ["sj"] = { "<CMD> split <CR>", "" },
      ["sl"] = { "<cmd> vsplit <CR>", "" },

      -- 调整分屏大小
      ["<up>"] = { "<CMD> res +5 <CR>", "" },
      ["<down>"] = { "<CMD> res -5 <CR>", "" },
      ["<left>"] = { "<CMD> vertical resize -5 <CR>", "" },
      ["<right>"] = { "<CMD> vertical resize +5 <CR>", "" },

      -- 打开当前文件目录
      ["<leader>op"] = { "<CMD>lua os.execute(\"open \" .. vim.fn.expand('%:p:h')) <CR>", "打开当前文件目录" },
   },
}

local diagnostic_opts = {
   -- focusable = false,
   -- close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
   -- border = "rounded", source = "always", prefix = " ", scope = "cursor",

   border = "rounded",
   scope = "line",
}
-- 重写nvchad lsp快捷键
M.lspconfig = {
   plugin = true,
   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

   n = {
      -- LSP
      ["<leader>lps"] = { "<CMD> LspStart <CR>", "啟動LSP服務" },
      ["<leader>lpr"] = { "<CMD> LspRestart <CR>", "重啟LSP服務" },
      ["<leader>lpk"] = { "<CMD> LspStop <CR>", "關閉LSP服務" },

      ["K"] = {
         function()
            vim.lsp.buf.hover()
         end,
         "顯示數據結構信息 - lsp hover",
      },

      ["<leader>e"] = {
         function()
            vim.diagnostic.open_float(nil, diagnostic_opts)
         end,
         "浮動顯示錯誤信息 - floating diagnostic",
      },

      ["[d"] = {
         function()
            vim.diagnostic.goto_prev { float = diagnostic_opts }
         end,
         "跳轉到上一個錯誤 - goto prev",
      },

      -- 原: d]
      ["]d"] = {
         function()
            vim.diagnostic.goto_next { float = diagnostic_opts }
         end,
         "跳轉到下一個錯誤 - goto_next",
      },

      ["<leader>q"] = {
         function()
            vim.diagnostic.setloclist()
         end,
         "底部顯示錯誤列表 - diagnostic setloclist",
      },

      ["gD"] = {
         function()
            vim.lsp.buf.declaration()
         end,
         "跳轉到聲明 - lsp declaration",
      },

      ["gd"] = {
         function()
            vim.lsp.buf.definition()
         end,
         "跳轉到定義 - lsp definition",
      },

      ["gi"] = {
         function()
            vim.lsp.buf.implementation()
         end,
         "跳轉到實現 - lsp implementation",
      },

      ["gr"] = {
         function()
            vim.lsp.buf.references()
         end,
         "跳轉到參考 - lsp references",
      },

      ["<leader>ra"] = {
         function()
            require("nvchad_ui.renamer").open()
         end,
         "修改名稱 - lsp rename",
      },
   },
}

M.plugin = {
   n = {
      -- 打开仪表盘
      -- mhinz/vim-startify
      ["DD"] = { "<CMD> Startify <CR>", "" },
      ["<leader>ss"] = { "<CMD> Startify <CR>", "打开startify仪表盘" },

      -- FZF
      ["<leader>fz"] = { "<CMD> FZF <CR>", "fzf文件搜索" },

      -- 切换文件管理器
      -- kyazdani42/nvim-tree.lua
      ["TT"] = { "<CMD> NvimTreeToggle <CR>", "切换nvimtree", opts = {} },
      ["<leader>tf"] = { "<CMD> NvimTreeFocus <CR>", "焦点在nvim-tree" },
      ["<leader>tr"] = { "<CMD> NvimTreeRefresh <CR>", "刷新nvim-tree列表" },
      ["<leader>tn"] = { "<CMD> NvimTreeFindFile <CR>", "定位文件所在nvim-tree位置" },
      ["<leader>tl"] = { "<CMD> NvimTreeCollapse <CR>", "折叠所有层级" },

      -- 歷史編輯管理器
      -- mbbill/undotree
      ["<leader>ud"] = { "<CMD> UndotreeToggle <CR>", "切换undo-tree" },

      -- Gitsigns
      -- lewis6991/gitsigns.nvim
      ["<leader>gf"] = { "<CMD> Gitsigns diffthis <CR>", "對比當前文件" },
      ["<leader>gd"] = { "<CMD> Gitsigns toggle_deleted <CR>", "最近已刪除的代碼" },

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

-- folke/persistence.nvim
M.session = {
   n = {
      ["<leader>sd"] = {
         function()
            local buf_list_len = vim.fn.len(vim.fn.getbufinfo { buflisted = 1 })
            if
               (buf_list_len == 0)
               or (buf_list_len == 1 and (vim.api.nvim_buf_get_name(0) == "" or vim.api.nvim_buf_line_count(0) == 1))
            then
               require("nvchad_ui.tabufline").close_buffer()
            end
            -- if buf_list_len == 0 then require("nvchad_ui.tabufline").close_buffer() end
            require("persistence").load()
            -- require("nvim-tree").toggle(false, true)
         end,
         "session: 恢复当前目录的会话",
      },

      ["<leader>sl"] = {
         "<CMD> lua require('persistence').load({ last = true }) <CR>",
         "session: 恢复上次会话",
      },
      ["<leader>sc"] = {
         "<CMD> lua require('persistence').stop() <CR>",
         "session: 退出时不会保存会话",
      },
   },
}

-- Pocco81/truezen.nvim
M.zen = {
   n = {
      ["<leader>zz"] = { "<CMD> ZenMode <CR>", "禪模式 (zen-mode)" },
      ["<leader>zi"] = {
         function()
            require("zen-mode").toggle { window = { width = 88 } }
         end,
         "禪模式: width = 88 (zen-mode)",
      },
      ["<leader>ze"] = {
         function()
            require("zen-mode").toggle { window = { width = 0.85 } }
         end,
         "禪模式: width = 85% (zen-mode)",
      },
      ["<leader>zo"] = {
         function()
            require("zen-mode").toggle { window = { width = 0.5 } }
         end,
         "禪模式: width = 50% (zen-mode)",
      },

      ["<leader>za"] = { "<CMD> TZAtaraxis <CR>", "禪模式 (truezen)" },
      ["<leader>zf"] = { "<CMD> TZFocus <CR>", "當有分屏時全屏" },
      ["<leader>zm"] = { "<CMD> TZMinimalist <CR>", "隱藏行號/狀態欄/標籤列" },
      ["<leader>zn"] = { "<CMD> TZNarrow <CR>", "禪模式-打開當前行" },
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

      ["<C-j><C-k>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   切換浮動終端",
      },

      ["<C-h><C-k>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   切換底部終端",
      },

      ["<C-v><C-k>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   切換右側終端",
      },
   },

   n = {
      -- 禁用ctrl+i按键
      -- ["<C-i>"] = { "<nop>", "" },

      ["<C-j><C-k>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   切換浮動終端",
      },

      ["<C-h><C-k>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   切換底部終端",
      },

      ["<C-v><C-k>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   切換右側終端",
      },

      -- new
      ["<leader>ht"] = {
         function()
            require("nvterm.terminal").new "horizontal"
         end,
         "   新建水平終端",
      },

      ["<leader>vt"] = {
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

M.lang = {
   n = {
      ["<leader>kn"] = {
         function()
            os.execute "killall nimsuggest"
         end,
         "kill掉所有nimsuggest进程",
      },
   },
}

M.game = {
   n = {
      -- ["<leader>gl"] = { "<CMD> GodotRunLast <CR>", "Godot-运行最后一个场景" },
      -- ["<leader>gr"] = { "<CMD> GodotRun <CR>", "Godot-运行特定场景/主场景" },
      -- ["<leader>gc"] = { "<CMD> GodotRunCurrent <CR>", "Godot-运行当前场景" },
      -- ["<leader>gz"] = { "<CMD> GodotRunFZF <CR>", "Godot-FZF查找并运行场景" },
      -- ["<leader>gr"] = { "<CMD> !godot <CR>", "Godot-运行特定场景/主场景" },

      ["<leader>gr"] = {
         function()
            local cmd, c, f = "", "", nil
            for _, v in pairs(config.game_project_cmd) do
               f = io.open(v[1], "r")
               if nil ~= f then
                  c = f:read "*a"
                  f:close()
                  cmd = "" ~= v[2] and (nil ~= string.find(c, v[2]) and v[3] or "") or v[3]
                  break
               end
            end
            if "" ~= cmd then
               require("nvterm.terminal").send(cmd, "vertical")
            end
         end,
         "运行游戏项目",
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

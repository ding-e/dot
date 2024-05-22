------------------------------------
-- 覆盖nvchad模塊/插件的配置
------------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- 關閉語言服務器的提示
--https://github.com/sumneko/lua-language-server/blob/master/locale/zh-tw/meta.lua

-- 合併2個或多個table
-- 參數1:
-- • error: 抛出错误
-- • keep : 使用最左边table的值
-- • force: 使用最右边table的值
local merge_tb = vim.tbl_deep_extend

-- local utils = require "core.utils"
local config = require "custom.config"
local icons = require "custom.icons"
local icon_index = config.icon_theme == "file" and 2 or 1
----------------------------------------------------

-- mbbill/undotree
function set_undotree()
   -- 顯示在右邊
   vim.g.undotree_WindowLayout = 3
   -- 寬度
   vim.g.undotree_SplitWidth = 50 --30
   -- 修改/刪除/添加高亮
   vim.g.undotree_HighlightChangedWithSign = 1
   vim.g.undotree_HighlightSyntaxChange = "DiffChange"
   vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
   vim.g.undotree_HighlightSyntaxDel = "DiffDelete"
end

-- kyazdani42/nvim-tree.lua
function set_nvimtree_opt()
   -- local opt = merge_tb("force", {}, config.nvtree["opt"] or {}) or {}
   local opt = {
      -- open_on_setup = true,
      view = {
         -- 是否自適應寬度
         adaptive_size = config.tree_adaptive_size,
         side = "left",
      },
      git = {
         enable = false,
         ignore = false,
      },
      renderer = {
         -- 是否隱藏tree頂部的當前目錄路徑
         root_folder_label = false,
         icons = {
            web_devicons = {
               file = {
                  enable = false,
                  color = true,
               },
               folder = {
                  enable = false,
                  color = true,
               },
            },
            show = {
               file = true,
               folder = true,
               folder_arrow = true,
               git = true,
            },
         },
         highlight_git = false,
      },
   }
   local nvimtree_icons = icons.nvimtree

   if config.icon_theme ~= "nvchad" then
      opt.renderer.icons.symlink_arrow = nvimtree_icons.symlink_arrow[icon_index]
      opt.renderer.icons.glyphs = {
         default = nvimtree_icons.file_default[icon_index],
         symlink = nvimtree_icons.symlink[icon_index],
         folder = {
            default = nvimtree_icons.folder_default[icon_index],
            empty = nvimtree_icons.folder_empty[icon_index],
            empty_open = nvimtree_icons.folder_empty_open[icon_index],
            open = nvimtree_icons.folder_open[icon_index],
            symlink = nvimtree_icons.folder_symlink[icon_index],
            symlink_open = nvimtree_icons.folder_symlink_open[icon_index],

            arrow_open = nvimtree_icons.folder_arrow_open[icon_index],
            arrow_closed = nvimtree_icons.folder_arrow_closed[icon_index],
         },
         git = {
            unstaged = nvimtree_icons.git_unstaged[icon_index],
            staged = nvimtree_icons.git_staged[icon_index],
            unmerged = nvimtree_icons.git_unmerged[icon_index],
            renamed = nvimtree_icons.git_renamed[icon_index],
            untracked = nvimtree_icons.git_untracked[icon_index],
            deleted = nvimtree_icons.git_deleted[icon_index],
            ignored = nvimtree_icons.git_ignored[icon_index],
         },
      }
   end
   return opt
end

function set_devicons_opt()
   return config.icon_theme == "none" and { default = false, color_icons = false }
       -- or { override = require("nvchad.icons").devicons }
       -- or { override = icons.devicons }
       -- or { override = merge_tb("force", require("nvchad.icons").devicons, icons["devicons"] or {}) }
       or { override = merge_tb("force", require "nvchad.icons.devicons", icons["devicons"] or {}) }
end

-- NvChad/nvterm
function set_nvterm(opts)
   require "base46.term"
   opts = merge_tb("force", opts, {
      terminals = {
         list = {},
         type_opts = {
            float = {
               relative = "editor",
               row = 0.16,
               col = 0.1,
               width = 0.8,
               height = 0.66,
               border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = 0.3 },
            vertical = { location = "rightbelow", split_ratio = 0.5 },
         },
      },
      behavior = {
         close_on_exit = true,
         auto_insert = true,
      },
      enable_new_mappings = true,
   })
   require("nvterm").setup(opts)
end

-- jose-elias-alvarez/null-ls.nvim
-- 具体支持语言
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
function set_nullls()
   local present, null_ls = pcall(require, "null-ls")
   if not present then
      return
   end

   -- require("custom.plugins.null-ls").setup()
   -- local null_ls = require "null-ls"
   local b = null_ls.builtins
   null_ls.setup {
      debug = true,
      sources = {
         -- lua
         b.formatting.stylua,
         -- b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

         b.formatting.gdformat,
         b.formatting.rustfmt,
         b.formatting.zigfmt,
         b.formatting.nimpretty.with { extra_args = { "--indent: 0" } },
         b.formatting.clang_format.with { extra_args = { "--style", "{IndentWidth: 4}" } },
      },
   }
end

-- folke/zen-mode.nvim
function set_zenmode()
   local present, zenmode = pcall(require, "zen-mode")
   if not present then
      return
   end

   zenmode.setup {
      window = {
         -- zen背景, 為1,則使用編輯背景一樣顏色
         backdrop = 0.95,
         -- zen寬高
         -- 等於1: 窗口大小
         -- 小於1: 窗口百分比
         -- 大於1: 使用該數值作為寬高
         width = 128,
         height = 1,
         options = {
            -- signcolumn = "yes",    -- 顯示git修改
            -- number = true,         -- 顯示行號
            -- relativenumber = true, -- 顯示行號
            -- cursorline = true,     -- 禁用光標行
            -- cursorcolumn = false,  -- 禁用光標列
            -- foldcolumn = "0",      -- 禁用折疊
            -- list = true,           -- 顯示空白字符
         },
      },
      plugins = {
         options = {
            enabled = false,
            ruler = true,
            showcmd = true,
         },
         -- folke/twilight.nvim
         twilight = { enabled = true },
         -- gitsigns
         gitsigns = { enabled = false },
         -- tmux狀態欄
         tmux = { enabled = false },
         -- this will change the font size on kitty when in zen mode
         -- to make this work, you need to set the following kitty options:
         -- - allow_remote_control socket-only
         -- - listen_on unix:/tmp/kitty
         kitty = {
            enabled = true,
            font = "+4",
         },
      },
      on_open = function(win) end,
      on_close = function() end,
   }
end

-- Pocco81/truezen.nvim
function set_truezen()
   local present, truezen = pcall(require, "true-zen")
   if not present then
      return
   end

   truezen.setup {
      modes = {
         minimalist = {
            ignored_buf_types = { "nofile" },
            options = {
               number = true,         -- false
               relativenumber = true, -- false
               signcolumn = "yes",    -- no
               -- statusline = "%!v:lua.require('nvchad').statusline()",

               showtabline = 0,
               cmdheight = 1,
               laststatus = 0,
               showcmd = false,
               showmode = false,
               ruler = false,
               numberwidth = 1,
            },
            callbacks = {
               open_pre = nil,
               open_pos = nil,
               close_pre = nil,
               close_pos = nil,
            },
         },
         ataraxis = {
            minimum_writing_area = {
               width = 100,
               height = 44,
            },
            callbacks = {
               open_pre = function() end,
               open_pos = function()
                  -- -- 打開後調用
                  -- -- :hi ColorColumn
                  -- -- 默認打開禪模式, 會關閉换行提示线(垂直), 將其開啟
                  -- vim.cmd [[
                  --    DeLineNumber
                  --    highlight ColorColumn guifg=none guibg=#2c2f30
                  -- ]]
               end,
               close_pre = nil,
               close_pos = nil,
            },
         },

         narrow = {
            callbacks = {
               open_pre = nil,
               open_pos = function()
                  -- -- :hi ColorColumn
                  -- -- narrow模式會打開禪模式, 禪模式下的callbacks也會被調用
                  -- -- narrow下關閉换行提示线(垂直)
                  -- vim.cmd [[
                  --    DeLineNumber 0
                  --    highlight ColorColumn guifg=#1e2122 guibg=#1e2122
                  -- ]]
               end,
               close_pre = nil,
               close_pos = nil,
            },
         },
      },
   }
end

-- session / workspace
-- folke/persistence.nvim
function set_session()
   local present, persistence = pcall(require, "persistence")
   if not present then
      return
   end

   persistence.setup {
      -- directory where session files are saved
      dir = vim.fn.expand(vim.fn.stdpath "config" .. "/sessions/"),
      -- sessionoptions used for saving
      options = { "buffers", "curdir", "tabpages", "winsize" },
   }
end

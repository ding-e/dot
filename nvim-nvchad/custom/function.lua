------------------------------------
-- 覆盖nvchad模塊/插件的配置
------------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- 關閉語言服務器的提示
--https://github.com/sumneko/lua-language-server/blob/master/locale/zh-tw/meta.lua

-- 合併2個或多個table
-- 參數1:
-- • error: 抛出错误
-- • keep : 使用最左边地图的值
-- • force: 使用最右边地图的值
local merge_tb = vim.tbl_deep_extend

local utils = require "core.utils"

local config = require "custom.config"
local icons = require "custom.icons"
local icon_index = config.icon_theme == "file" and 2 or 1

----------------------------------- functions ---------------------------------
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
function set_nvimtree()
   -- local opt = merge_tb("force", {}, config.nvtree["opt"] or {}) or {}
   local opt = {
      -- open_on_setup = true,
      view = {
         -- 是否自適應寬度
         adaptive_size = true,
         side = "left",

         -- 是否隱藏tree頂部的當前目錄路徑
         hide_root_folder = true,
      },
      git = {
         enable = false,
         ignore = false,
      },
      renderer = {
         icons = {
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

-- kyazdani42/nvim-web-devicons
function set_devicons()
   local present, devicons = pcall(require, "nvim-web-devicons")
   if not present then
      return
   end

   require("base46").load_highlight "devicons"

   local opt = config.icon_theme == "none" and { default = false, color_icons = false }
      -- or { override = require("nvchad_ui.icons").devicons }
      -- or { override = icons.devicons }
      or { override = merge_tb("force", require("nvchad_ui.icons").devicons, icons["devicons"] or {}) }

   devicons.setup(utils.load_override(opt, "kyazdani42/nvim-web-devicons"))
end

-- NvChad/ui
function set_ui()
   return {
      statusline = {
         separator_style = "block", -- default/round/block/arrow
         -- or
         -- custom separators
         -- separator_style = {
         --    left = " ",
         --    right = "",
         --  },

         overriden_modules = function()
            return require "custom.statusline"
         end,
      },
      -- statusline = require "custom.statusline",

      -- lazyload it when there are 1+ buffers
      tabufline = {
         enabled = true,
         lazyload = false,
         overriden_modules = function()
            return require "custom.tabufline"
         end,
      },
   }
end

-- NvChad/nvterm
function set_nvterm()
   return {
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
   }
end

-- lewis6991/gitsigns.nvim
function set_gitsigns()
   local present, gitsigns = pcall(require, "gitsigns")
   if not present then
      return
   end

   require("base46").load_highlight "git"
   local gitsigns_icons = icons.gitsigns
   icon_index = config.icon_theme == "none" and 1 or 2

   gitsigns.setup(utils.load_override({
      -- 行號下的git圖標設置
      signs = {
         add = {
            hl = "DiffAdd",
            text = gitsigns_icons.add[icon_index],
            numhl = "GitSignsAddNr",
         },
         change = {
            hl = "DiffChange",
            text = gitsigns_icons.change[icon_index],
            numhl = "GitSignsChangeNr",
         },
         delete = {
            hl = "DiffDelete",
            text = gitsigns_icons.delete[icon_index],
            numhl = "GitSignsDeleteNr",
         },
         topdelete = {
            hl = "DiffDelete",
            text = gitsigns_icons.topdelete[icon_index],
            numhl = "GitSignsDeleteNr",
         },
         changedelete = {
            hl = "DiffChangeDelete",
            text = gitsigns_icons.changedelete[icon_index],
            numhl = "GitSignsChangeNr",
         },
      },
      on_attach = function(bufnr)
         utils.load_mappings("gitsigns", { buffer = bufnr })
      end,
   }, "lewis6991/gitsigns.nvim"))
end

-- folke/zen-mode.nvim
function set_zenmode()
   require("zen-mode").setup {
      window = {
         -- zen背景, 為1,則使用編輯背景一樣顏色
         backdrop = 0.95,
         -- zen寬高
         -- 等於1: 窗口大小
         -- 小於1: 窗口百分比
         -- 大於1: 使用該數值作為寬高
         width = 126,
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
         -- 是否禁用gitsigns
         gitsigns = { enabled = false },
         -- 是否禁用tmux狀態欄
         tmux = { enabled = false },
         -- this will change the font size on kitty when in zen mode
         -- to make this work, you need to set the following kitty options:
         -- - allow_remote_control socket-only
         -- - listen_on unix:/tmp/kitty
         kitty = {
            -- 禁用
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
   require("true-zen").setup {
      modes = {
         minimalist = {
            ignored_buf_types = { "nofile" },
            options = {
               number = true, -- false
               relativenumber = true, -- false
               signcolumn = "yes", -- no
               -- statusline = "%!v:lua.require('nvchad_ui').statusline()",

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
                  -- -- 默認打開禪模式, 會關閉屏幕竪線, 將其開啟
                  -- vim.cmd [[
                  --    DeNumber 1
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
                  -- -- narrow下關閉屏幕竪線
                  -- vim.cmd [[
                  --    DeNumber
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

-- jose-elias-alvarez/null-ls.nvim
-- 具体支持语言
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
function set_nullls()
   -- require("custom.plugins.null-ls").setup()
   local null_ls = require "null-ls"
   local b = null_ls.builtins
   null_ls.setup {
      debug = true,
      sources = {
         -- lua
         b.formatting.stylua,
         -- b.diagnostics.luacheck.with { extra_args = { "--global vim" } },
         -- zig
         b.formatting.zigfmt,
         -- nim
         b.formatting.nimpretty,
         -- clang
         b.formatting.clang_format.with { extra_args = { "--style", "{IndentWidth: 4}" } },
      },
   }
end

-- NvChad/base46
function set_base46()
   local ok, base46 = pcall(require, "base46")
   if not ok then
      return
   end

   base46.load_theme()
   -- :echo expand('%:e')           -- 查看當前編輯文件的後綴
   -- :lua print(vim.fn.getcwd())   -- 查看當前root path
   -- :lua require("base46").toggle_theme()
   -- :lua require("nvchad").reload_theme("gruvchad")

   -- 根據當前項目設置nvchad配色
   local t = 2
   for _, v in pairs(config.workspace_list) do
      local wt = nil ~= string.find(v, "/") and v or "workspace/" .. v
      if nil ~= string.find(string.lower(vim.fn.getcwd()), wt) and t ~= 1 then
         t = 1
         break
      end
   end
   require("nvchad").reload_theme(config.workspace_theme_toggle[t])
end

-- session / workspace
-- folke/persistence.nvim
function set_session()
   require("persistence").setup {
      -- directory where session files are saved
      dir = vim.fn.expand(vim.fn.stdpath "config" .. "/sessions/"),
      -- sessionoptions used for saving
      options = { "buffers", "curdir", "tabpages", "winsize" },
   }
end

-- -- Shatur/neovim-session-manager
-- function set_neovim_session()
--    local Path = require "plenary.path"
--    require("session_manager").setup {
--       sessions_dir = Path:new(vim.fn.stdpath "data", "sessions"),
--       path_replacer = "__",
--       colon_replacer = "++",
--       -- autoload_mode = require("session_manager.config").AutoloadMode.LastSession,
--       autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
--       autosave_last_session = true,
--       autosave_ignore_not_normal = true,
--       autosave_ignore_dirs = {},
--       autosave_ignore_filetypes = { "gitcommit" },
--       autosave_ignore_buftypes = {},
--       autosave_only_in_session = false,
--       max_path_length = 80,
--    }
--
--    -- 使用session插件，当打开vim时是否自动打开nvim-tree
--    -- vim.cmd [[
--    --    augroup _open_nvim_tree
--    --       autocmd! * <buffer>
--    --       autocmd SessionLoadPost * silent! lua require("nvim-tree").toggle(false, true)
--    --    augroup end
--    -- ]]
--
--    -- A global group for all your config autocommands
--    local config_group = vim.api.nvim_create_augroup("MyConfigGroup", {})
--    vim.api.nvim_create_autocmd({ "User" }, {
--       pattern = "SessionLoadPost",
--       group = config_group,
--       callback = function()
--          -- require("nvim-tree").toggle(false, true)
--          vim.cmd [[
--             " PackerLoad nvim-tree.lua
--             " NvimTreeToggle
--
--             " vertical wincmd l
--             " wincmd w
--             " noautocmd wincmd p
--
--             Startify
--             PackerCompile
--          ]]
--       end,
--    })
-- end

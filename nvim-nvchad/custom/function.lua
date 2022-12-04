-- 關閉全局小寫開頭函數提示
---@diagnostic disable: lowercase-global, unused-local
--https://github.com/sumneko/lua-language-server/blob/master/locale/zh-tw/meta.lua

local utils = require "core.utils"
local load_override = require("core.utils").load_override
local custom_icons = require "custom.icons"

----------------------------------- functions ---------------------------------

-- nvim-web-devicons, nvim-tree.lua icon
function set_devicons()
   local present, devicons = pcall(require, "nvim-web-devicons")
   if present then
      require("base46").load_highlight "devicons"

      local config = require("core.utils").load_config()
      local icon_index = config.ui.icon_theme == "file" and 2 or 1

      local nvimtree_icons = require("custom.override").nvimtree.renderer.icons
      local options = { override = require("nvchad_ui.icons").devicons }
      local glyphs = nvimtree_icons.glyphs
      local icons = custom_icons.nvtree

      if config.ui.icon_theme ~= "nvchad" then
         if config.ui.icon_theme == "none" then
            options = { default = false, color_icons = false }
         end
         nvimtree_icons.symlink_arrow = custom_icons.nvtree.symlink_arrow[icon_index]
         glyphs.default = custom_icons.nvtree.file_default[icon_index]
         glyphs.symlink = icons.symlink[icon_index]
         glyphs.folder = {
            default = icons.folder_default[icon_index],
            empty = icons.folder_empty[icon_index],
            empty_open = icons.folder_empty_open[icon_index],
            open = icons.folder_open[icon_index],
            symlink = icons.folder_symlink[icon_index],
            symlink_open = icons.folder_symlink_open[icon_index],

            arrow_open = icons.folder_arrow_open[icon_index],
            arrow_closed = icons.folder_arrow_closed[icon_index],
         }
      end

      options = load_override(options, "kyazdani42/nvim-web-devicons")
      devicons.setup(options)
   end
end

-- gitsigns-usage
function set_gitsigns()
   local present, gitsigns = pcall(require, "gitsigns")

   if not present then
      return
   end

   require("base46").load_highlight "git"

   local config = require("core.utils").load_config()
   local icon_index = config.ui.icon_theme == "none" and 1 or 2
   local icons = custom_icons.gitsigns

   local options = {
      -- 行號下的git圖標設置
      signs = {
         -- add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
         -- change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
         -- -- delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
         -- delete = { hl = "DiffDelete", text = "D", numhl = "GitSignsDeleteNr" },
         -- topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
         -- changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
         add = { hl = "DiffAdd", text = icons.add[icon_index], numhl = "GitSignsAddNr" },
         change = { hl = "DiffChange", text = icons.change[icon_index], numhl = "GitSignsChangeNr" },
         delete = { hl = "DiffDelete", text = icons.delete[icon_index], numhl = "GitSignsDeleteNr" },
         topdelete = { hl = "DiffDelete", text = icons.topdelete[icon_index], numhl = "GitSignsDeleteNr" },
         changedelete = { hl = "DiffChangeDelete", text = icons.changedelete[icon_index], numhl = "GitSignsChangeNr" },
      },
      on_attach = function(bufnr)
         utils.load_mappings("gitsigns", { buffer = bufnr })
      end,
   }

   options = load_override(options, "lewis6991/gitsigns.nvim")
   gitsigns.setup(options)
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

-- Pocco81/truezen.nvim
function set_truezen()
   require("true-zen").setup {
      modes = {
         ataraxis = {
            minimum_writing_area = { -- minimum size of main window
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

-- NvChad/base46
function set_base46()
   local ok, base46 = pcall(require, "base46")

   if ok then
      base46.load_theme()

      -- :echo expand('%:e')           -- 查看當前編輯文件的後綴
      -- :lua print(vim.fn.getcwd())   -- 查看當前root path
      -- :lua require("base46").toggle_theme()
      -- :lua require("nvchad").reload_theme("gruvchad")

      -- 根據當前項目設置nvchad配色
      local config = require("core.utils").load_config()
      local t = 2
      for _, v in pairs(config.ui.workspace_list) do
         local wt = nil ~= string.find(v, "/") and v or "workspace/" .. v
         if nil ~= string.find(string.lower(vim.fn.getcwd()), wt) and t ~= 1 then
            t = 1
            break
         end
      end
      require("nvchad").reload_theme(config.ui.workspace_theme_toggle[t])
   end
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

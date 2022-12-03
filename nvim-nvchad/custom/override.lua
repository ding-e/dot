------------------------------------
-- 覆盖nvchad模塊/插件的配置
------------------------------

local utils = require "core.utils"
local load_override = require("core.utils").load_override
local M = {}

local custom_icons = require("custom.icons")

-------------------------------------------------------- functions ------------------------------------------------------------
function Set_icons()
   local present, devicons = pcall(require, "nvim-web-devicons")
   if present then
      require("base46").load_highlight "devicons"

      local config = require("core.utils").load_config()
      local icon_index = config.ui.icon_theme == "file" and 2 or 1

      local options = { override = require("nvchad_ui.icons").devicons }
      local glyphs = M.nvimtree.renderer.icons.glyphs
      local icons = custom_icons.nvtree

      if config.ui.icon_theme ~= "nvchad" then
         if config.ui.icon_theme == "none" then options = { default = false, color_icons = false } end
         M.nvimtree.renderer.icons.symlink_arrow = custom_icons.nvtree.symlink_arrow[icon_index]
         glyphs.default  = custom_icons.nvtree.file_default[icon_index]
         glyphs.symlink  = icons.symlink[icon_index]
         glyphs.folder   = {
            default      = icons.folder_default[icon_index],
            empty        = icons.folder_empty[icon_index],
            empty_open   = icons.folder_empty_open[icon_index],
            open         = icons.folder_open[icon_index],
            symlink      = icons.folder_symlink[icon_index],
            symlink_open = icons.folder_symlink_open[icon_index],

            arrow_open   = icons.folder_arrow_open[icon_index],
            arrow_closed = icons.folder_arrow_closed[icon_index],
         }
      end

      options = load_override(options, "kyazdani42/nvim-web-devicons")
      devicons.setup(options)
   end
end

-- gitsigns-usage
function Set_gitsigns ()
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



-------------------------------------------------------- return ------------------------------------------------------------
M.nvimtree = {
   -- open_on_setup = true,
   view = {
      -- 是否自適應寬度
      adaptive_size = true,
      side = "left",
      width = 25,
      -- 是否隱藏tree頂部的當前目錄路徑
      hide_root_folder = true,
   },
   git = {
      enable = false,
      ignore = false,
   },
   renderer = {
      highlight_git = false,
      icons = {
         show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
         },
         symlink_arrow = " ➛ ",
         glyphs = {
            default = "",
            symlink = "",
            folder = {
               default = "",
               empty = "",
               empty_open = "",
               open = "",
               symlink = "",
               symlink_open = "",
               arrow_open = "",
               arrow_closed = "",
            },
            git = {
               unstaged = "✗",
               staged = "✓",
               unmerged = "",
               renamed = "➜",
               untracked = "★",
               deleted = "",
               ignored = "◌",
            },
         },
      },
   },
}

M.nvterm = {
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

M.ui = {
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
      lazyload = true,
      overriden_modules = function()
         return require "custom.tabufline"
      end,
   },
}

return M

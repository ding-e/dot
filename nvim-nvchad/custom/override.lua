-- 覆盖插件配置

local M = {}

function Set_icons()
   local present, devicons = pcall(require, "nvim-web-devicons")
   if present then
      require("base46").load_highlight "devicons"

      local icon_theme = require("core.utils").load_config().ui.icon_theme
      local options = { override = require("nvchad_ui.icons").devicons }

      M.nvimtree.renderer.icons.glyphs.default = ""
      M.nvimtree.renderer.icons.glyphs.symlink = ""
      M.nvimtree.renderer.icons.glyphs.folder = {
         default = "D",
         empty = "D",
         empty_open = "D",
         open = "D",
         symlink = "L",
         symlink_open = "L",
         arrow_open = "",
         arrow_closed = "",
      }

      if icon_theme == "none" then
         options = { default = false, color_icons = false }
         M.nvimtree.renderer.icons.glyphs.default = "F"
         M.nvimtree.renderer.icons.glyphs.symlink = "L"
      elseif icon_theme == "nvchad" then
         M.nvimtree.renderer.icons.glyphs.folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
         }
      end

      options = require("core.utils").load_override(options, "kyazdani42/nvim-web-devicons")
      devicons.setup(options)
   end
end

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
         symlink_arrow = " -> ",
         glyphs = {
            default = "F",
            symlink = "L",
            folder = {
               default = "D",
               empty = "D",
               empty_open = "D",
               open = "D",
               symlink = "L",
               symlink_open = "L",
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

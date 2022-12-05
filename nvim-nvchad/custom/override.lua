------------------------------------
-- 覆盖nvchad模塊/插件的配置
------------------------------

local M = {}

M.nvimtree = function()
   local opt = {
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
         highlight_git = false,
      },
   }

   local config = require("custom.config")
   local icon_index = config.icon_theme == "file" and 2 or 1
   local nvtree_icons = require("custom.icons").nvtree

   if config.icon_theme ~= "nvchad" then
      opt.renderer.icons.symlink_arrow = nvtree_icons.symlink_arrow[icon_index]
      opt.renderer.icons.glyphs.default = nvtree_icons.file_default[icon_index]
      opt.renderer.icons.glyphs.symlink = nvtree_icons.symlink[icon_index]
      opt.renderer.icons.glyphs.folder = {
         default = nvtree_icons.folder_default[icon_index],
         empty = nvtree_icons.folder_empty[icon_index],
         empty_open = nvtree_icons.folder_empty_open[icon_index],
         open = nvtree_icons.folder_open[icon_index],
         symlink = nvtree_icons.folder_symlink[icon_index],
         symlink_open = nvtree_icons.folder_symlink_open[icon_index],

         arrow_open = nvtree_icons.folder_arrow_open[icon_index],
         arrow_closed = nvtree_icons.folder_arrow_closed[icon_index],
      }
   end
   return opt
end

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
      lazyload = false,
      overriden_modules = function()
         return require "custom.tabufline"
      end,
   },
}

return M

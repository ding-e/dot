-- 覆盖插件配置

local M = {}

M.nvimtree = {
   view = {
      -- 是否自適應寬度
      adaptive_size = true,
      side = "left",
      width = 25,
      -- 是否隱藏tree頂部的當前目錄路徑
      hide_root_folder = true,
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

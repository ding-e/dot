------------------------------------
-- nvchad 自定義配置
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local config = require "configs.config"
local tabufline = require "override.tabufline"
local statusline = require "override.statusline"

-- local tabufline = require "dinge.tabufline"
-- for k, v in ipairs(tabufline.get_modules_arr()) do
--   M.ui.tabufline.modules[k] = v
-- end

M.ui = {
   theme = "dinge", -- dinge, gruvchad, one_light, ashes
   theme_toggle = { "dinge", "ashes" },
   transparency = false,

   -- hl_override = {
   --   Comment = { italic = true },
   --   ["@comment"] = { italic = true },
   -- },

   term = {
      hl = "Normal:term,WinSeparator:WinSeparator",
      sizes = { sp = 0.3, vsp = 0.2 },
      float = {
         relative = "editor",
         row = 0.16,
         col = 0.1,
         width = 0.8,
         height = 0.66,
         border = "single",
      },
   },

   tabufline = {
      enabled = true,
      lazyload = false,
      --  more opts
      order = config.tabufline_other,
      modules = {
         treeOffset = tabufline.treeOffset,
         buffers = tabufline.buffers,
         tabs = tabufline.tabs,
         btns = tabufline.btns,

         -- You can add your custom component -- abc = function()
         -- abc = function()
         --   return "hi"
         -- end,
      },
   },

   statusline = {
      -- more opts
      -- order = { ... }, -- check stl/utils.lua file in ui repo
      order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "current_time", "cwd", "cursor" },
      modules = {
         mode = statusline.mode,
         file = statusline.file,
         git = statusline.git,
         -- "%=",
         lsp_msg = statusline.lsp_msg,
         -- "%=",
         diagnostics = statusline.diagnostics,
         lsp = statusline.lsp, -- or "",
         current_time = statusline.current_time,
         -- current_time = function ()
         --    return "abc"
         -- end,
         -- statusline.current_time,
         cwd = statusline.cwd,
         -- cursor = statusline.cursor,
         cursor = function()
            return statusline.cursor
         end,

         -- The default cursor module is override
         -- cursor = function()
         --    return "%#BruhHl#" .. " bruh " -- the highlight group here is BruhHl      end,
         -- end,
      },
   },
}

return M

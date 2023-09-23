------------------------------------
-- nvchad 自定義配置
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- -@type ChadrcConfig
local M = {}

local config = require "custom.config"
-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.options = {
   nvChad = {
      update_url = "https://github.com/NvChad/NvChad",
      update_branch = "2.0",
   },
}

M.ui = {
   theme = config.theme,
   theme_toggle = config.theme_toggle,
   transparency = false,

   hl_override = highlights.override,
   hl_add = highlights.add,

   statusline = {
      -- theme = "minimal", -- "default" -- "vscode",
      separator_style = "block", -- default/round/block/arrow
      overriden_modules = function(modules)
         local statusline = require "custom.statusline"
         for k, v in ipairs(statusline.get_modules_arr()) do
            modules[k] = v
         end
      end,
   },

   -- lazyload it when there are 1+ buffers
   tabufline = {
      enabled = true,
      lazyload = false,
      overriden_modules = function(modules)
         local tabufline = require "custom.tabufline"
         for k, v in ipairs(tabufline.get_modules_arr()) do
            modules[k] = v
         end
      end,
   },
}

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"

return M

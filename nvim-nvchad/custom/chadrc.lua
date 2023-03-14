------------------------------------
-- nvchad 自定義配置
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

local config = require "custom.config"

local M = {}

M.options = {
   nvChad = {
      -- update_url = "https://github.com/NvChad/NvChad",
      -- update_branch = "main",
      update_url = "https://github.com/ding-e/NvChad-1.0",
      update_branch = "1.0",
   },
}

M.ui = {
   theme = config.theme,
   theme_toggle = config.theme_toggle,
   transparency = false,
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

return M

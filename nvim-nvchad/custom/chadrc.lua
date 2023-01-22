------------------------------------
-- nvchad 自定義配置
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

local config = require "custom.config"

local M = {}

M.ui = {
   theme = config.theme,
   theme_toggle = config.theme_toggle,
   transparency = false,
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

return M

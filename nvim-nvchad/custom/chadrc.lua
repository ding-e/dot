------------------------------------
-- nvchad 自定義配置
---------------------------

local config = require("custom.config")

local M = {}

M.ui = {
   theme = config.theme,
   theme_toggle = config.theme_toggle,
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

return M

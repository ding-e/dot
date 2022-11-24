local M = {}

M.ui = {
   theme = "dinge",
   theme_toggle = { "gruvchad", "dinge" },

   ------------------------------
   -- 自定義配置項
   --------------------
   -- 項目列表
   workspace_list = { "nim", "dot", "zig", "nvim", ".config/nvim" },
   -- 如果當前項目存在workspace_list中使用第一個主題
   -- 否則使用第二個
   workspace_theme_toggle = { "dinge", "gruvchad" },
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

return M

------------------------------------
-- nvchad 自定義配置
---------------------------

local M = {}

M.ui = {
   theme = "gruvchad",
   theme_toggle = { "gruvchad", "dinge" },

   ------------------------------
   -- 自定義配置項
   --------------------
   -- 項目列表
   workspace_list = { "nim", "dot", "zig", "nvim", ".config/nvim" },
   -- 如果當前項目存在workspace_list中使用第一個主題
   -- 否則使用第二個
   workspace_theme_toggle = { "dinge", "gruvchad" },

   -- 圖標相關 (nvim-tree/tabufline)
   -- "none", "file", "nvchad"
   icon_theme = "file",
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

if M.ui.icon_theme == "file" and os.getenv("TERM_PROGRAM") == "iTerm.app" then
   M.ui.icon_theme = "nvchad"
end

return M

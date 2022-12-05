------------------------------------
-- 自定義配置項
---------------------------

local M = {

   theme = "gruvchad",
   theme_toggle = { "gruvchad", "dinge" },

   -- 項目列表
   workspace_list = { "nim", "dot", "zig", "nvim", ".config/nvim" },
   -- 如果當前項目存在workspace_list中使用第一個主題
   -- 否則使用第二個
   workspace_theme_toggle = { "dinge", "gruvchad" },

   -- 圖標相關 (nvim-tree/tabufline)
   -- "none", "file", "nvchad"
   icon_theme = "file",
}

if M.icon_theme == "file" and os.getenv("TERM_PROGRAM") == "iTerm.app" then
   M.icon_theme = "nvchad"
end

return M

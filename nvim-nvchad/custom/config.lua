------------------------------------
-- 自定義配置項
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

local utils = require "custom.utils"
local M = {

   theme = "gruvchad", -- one_light
   theme_toggle = { "gruvchad", "dinge" },

   -- 項目列表
   workspace_list = { "nim", "dot", "zig", "nvim",
                      "love2d", "godot", ".config/nvim" },
   -- 如果當前項目存在workspace_list中使用第一個主題
   -- 否則使用第二個
   workspace_theme_toggle = { "dinge", "gruvchad" },

   -- 圖標相關 (nvim-tree/tabufline)
   -- "none", "file", "nvchad"
   icon_theme = "file",

   -- nvimtree是否自適應寬度
   tree_adaptive_size = false,

   -- 根据当前项目特征指定对应游戏引擎运行
   game_project_cmd = {
      love = { ".luarc.json", "love2d", "clear && love .", init = true },
      godot = { "project.godot", "", "clear && godot", init = false },
   },

   -- mason, tree-sitter
   mason_list = { "lua-language-server", "clangd" },
   treesitter_list = { "vim", "lua", "rust", "c" },
}

M.theme = utils.get_workspace_theme(M.workspace_list, M.workspace_theme_toggle)
-- leader+fm 格式化
vim.g.zig_fmt_autosave = 0

if M.icon_theme == "file" and os.getenv "TERM_PROGRAM" == "iTerm.app" then
   M.icon_theme = "nvchad"
elseif io.popen("uname -n", "r"):read "*l" == "de-arch" then
   M.icon_theme = "none"
end

return M

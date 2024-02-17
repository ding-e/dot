------------------------------------
-- 自定義配置項
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- os.getenv "TERM_PROGRAM" == "iTerm.app"

local utils = require "custom.utils"
local M = {

   theme = "gruvchad", -- one_light

   -- 如果當前項目存在workspace_list中使用第一個主題
   -- 否則使用第二個
   theme_toggle = { "dinge", "gruvchad" },

   -- 項目列表
   workspace_list = { "nim", "dot", "zig", "nvim",
                      "love2d", "godot", ".config/nvim" },

   -- 圖標相關 (nvim-tree/tabufline)
   -- "none", "file", "nvchad"
   icon_theme = "none",

   -- nvimtree是否自適應寬度
   tree_adaptive_size = false,

   -- TODO... auto: 檢測寬高自動匹配
   -- horizontal / vertical / float
   project_term_type = "vertical",
   -- 根据当前项目特征執行對應命令
   project_cmd_list = {
      -- 模板名稱       文件查詢        匹配內容      執行命令           是否复制
      love      = { ".luarc.json",   "love2d", "clear && love .", init = true  },
      godot     = { "project.godot", "",       "clear && godot",  init = false },
      c_project = { "c.project",     "",       "./build.sh",      init = false },
   },

   -- mason, tree-sitter
   mason_list = { "lua-language-server" }, -- "clangd", "haxe-language-server"
   treesitter_list = { "vim", "lua", "rust", "c" },
}

if utils.is_linux() then M.icon_theme = "none" end
M.theme = utils.get_workspace_theme(M.workspace_list, M.theme_toggle)

-- leader+fm 格式化
vim.g.zig_fmt_autosave = 0

return M

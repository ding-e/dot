------------------------------------
-- 自定義配置項
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- os.getenv "TERM_PROGRAM" == "iTerm.app"

-- local utils = require "utils.func"
local M = {

   -- theme = "dinge", -- gruvchad, one_light, ashes
   -- theme_toggle = { "dinge", "ashes" },

   -- 标签ui模块排序
   tabufline_order = { "treeOffset", "buffers", "tabs", "btns" },

   -- nvimtree是否自適應寬度
   tree_adaptive_size = false,

   -- 項目列表
   workspace_list = { "nim", "dot", "zig", "nvim", "love2d", "godot", ".config/nvim" },

   -- htoggleTerm / vtoggleTerm / floatTerm / nvimCMD
   project_term_type = "nvimCMD",
   -- 根据当前项目特征執行對應命令
   project_cmd_list = {
      -- 模板名稱       文件查詢        匹配內容      執行命令           是否复制
      love      = {   ".luarc.json",    "love2d",  "clear && love .",  init = true  },
      godot     = {   "project.godot",  "",        "clear && godot",   init = false },
      c_project = {   "c.project",      "",        "./build.sh",       init = false },
   },

   -- mason, tree-sitter
   mason_list = { "lua-language-server" }, -- "clangd", "haxe-language-server"
   treesitter_list = { "vim", "lua", "rust", "c" },
}
-- M.theme = utils.get_workspace_theme(M.workspace_list, M.theme_toggle)

-- leader+fm 格式化
vim.g.zig_fmt_autosave = 0

return M

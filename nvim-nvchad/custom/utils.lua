------------------------------------
-- 工具函数
---------------------------
local M = {}

M.table_len = function(t)
   local r = 0
   for _, _ in pairs(t) do
      r = r + 1
   end
   return r
end

M.get_workspace_theme = function(project_list, theme_list)
   -- 根據當前項目設置nvchad配色
   local t = 2
   for _, v in pairs(project_list) do
      local wt = nil ~= string.find(v, "/") and v or "workspace/" .. v
      if nil ~= string.find(string.lower(vim.fn.getcwd()), wt) and t ~= 1 then
         t = 1
         break
      end
   end

   return theme_list[t]
end

M.set_theme = function(theme_name)
   vim.g.nvchad_theme = theme_name
   require("base46").load_all_highlights()
end

M.get_filemanager_cmd = function()
   local c = "open"
   if M.is_linux() then
      c = "thunar"
   end
   return c
end

M.is_linux = function()
   if io.popen("uname -o", "r"):read "*l" == "GNU/Linux" then
      return true
   end
   return false
end

M.is_macos = function()
   if io.popen("uname -o", "r"):read "*l" == "Darwin" then
      return true
   end
   return false
end

M.is_tmux = function()
   if os.getenv "TERM_PROGRAM" == "tmux" then
      return true
   end
   return false
end

return M

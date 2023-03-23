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

return M

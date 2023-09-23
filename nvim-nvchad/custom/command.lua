------------------------------------
-- 自定義命令
------------------
---@diagnostic disable: lowercase-global, undefined-global

local config = require "custom.config"
local utils = require "custom.utils"
local create_cmd = vim.api.nvim_create_user_command

-- 顯示/隱藏 行號
-- DeLineNumber    -> 顯示行號
-- DeLineNumber 0  -> 刪除行號
create_cmd("DeLineNumber", function(args)
   if  "" ~= args.args then
      vim.cmd [[ set nonumber
                 set norelativenumber ]]
   else
      vim.cmd [[ set number
                 set relativenumber ]]
   end
end, { nargs = "*", desc = "" })

-- 查看nvim快捷鍵
-- DeNvimKey   -> 查看自定義快捷鍵
-- DeNvimKey 0 -> 查看nvchad快捷鍵
create_cmd("DeNvimKey", function(args)
   if "" ~= args.args then
      vim.cmd [[ vsp $HOME/.config/nvim/lua/core/mappings.lua ]]
   else
      vim.cmd [[ vsp $HOME/.config/nvim/lua/custom/mappings.lua ]]
   end
end, { nargs = "*", desc = "" })

-- 查看nvim快捷鍵(NvCheatsheet/Telescope keymaps)
create_cmd("DeNvchadKey", function(args)
   if "" ~= args.args then
      vim.cmd [[ Telescope keymaps ]]
   else
      vim.cmd [[ NvCheatsheet ]]
   end
end, { nargs = "*", desc = "" })

-- 查看dwm快捷鍵
create_cmd("DeDwmKey", function(_)
   vim.cmd [[ vsp $HOME/core/software/dwm.win95/config.h ]]
end, { nargs = "*", desc = "" })

-- 打开nvchad config.lua
create_cmd("DeNvchadConfig", function(_)
   vim.cmd [[ e $HOME/.config/nvim/lua/custom/config.lua ]]
end, { nargs = "*", desc = "" })

-- 添加一個全屏終端(tab)
-- DeTerm   -> 新建標籤並創建終端
-- DeTerm 0 -> 關閉當前所處的標籤
create_cmd("DeTerm", function(args)
   if "" ~= args.args then
      -- TODO...
      vim.cmd [[
         lua require("nvchad.tabufline").close_buffer()
         tabc
      ]]
   else
      vim.cmd [[
         tabe
         term
         DeLineNumber 0
      ]]
   end
end, { nargs = "*", desc = "" })

-- 是否顯示换行提示线(垂直)
-- DeColorcolumn   -> 開啟
-- DeColorcolumn 0 -> 關閉
create_cmd("DeColorcolumn", function(args)
   if "" ~= args.args then
      vim.cmd [[ highlight ColorColumn guifg=#1e2122 guibg=#1e2122 ]]
   else
      vim.cmd [[ highlight ColorColumn guifg=none guibg=#2c2f30 ]]
   end
end, { nargs = "*", desc = "" })

-- 为项目生产预设文件
-- DeProjectinit $config.project_cmd_list key
create_cmd("DeProjectinit", function(args)
   local c, l = string.gsub(args.args, "^%s*(.-)%s*$", "%1"), ""
   local len, i = utils.table_len(config.project_cmd_list), 0
   local template_path = "$HOME/.config/nvim/lua/custom/template/"
   -- TODO...
   for k, v in pairs(config.project_cmd_list) do
      if false ~= v.init then
         if c == k then
            os.execute("cp -R " .. template_path .. k .. "/. . 2>/dev/null")
            break
         end
         l = l .. k .. " "
         i = i + 1
      else
         len = len - 1
      end
      if i >= len then
         print("ERROR - 目前可初始化的项目: [ " .. l .. "]")
      end
   end
end, { nargs = "*", desc = "" })

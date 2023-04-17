------------------------------------
-- 自定義命令
------------------
---@diagnostic disable: lowercase-global, undefined-global

local config = require "custom.config"
local utils = require "custom.utils"
local create_cmd = vim.api.nvim_create_user_command

-- 顯示/隱藏 行號
-- DeNumber   -> 刪除行號
-- DeNumber 1 -> 顯示行號
create_cmd("DeNumber", function(args)
   if args.args == "1" then
      vim.cmd [[ set number
                 set relativenumber ]]
   else
      vim.cmd [[ set nonumber
                 set norelativenumber ]]
   end
end, { nargs = "*", desc = "" })

-- 查看nvim快捷鍵
-- DeNvimKey   -> 查看自定義快捷鍵
-- DeNvimKey 1 -> 查看nvchad快捷鍵
create_cmd("DeNvimKey", function(args)
   if args.args == "1" then
      vim.cmd [[ vsp $HOME/.config/nvim/lua/core/mappings.lua ]]
   else
      vim.cmd [[ vsp $HOME/.config/nvim/lua/custom/mappings.lua ]]
   end
end, { nargs = "*", desc = "" })

-- 查看dwm快捷鍵
create_cmd("DeDwmKey", function()
   vim.cmd [[ vsp $HOME/core/software/dwm.win95/config.h ]]
end, { nargs = "*", desc = "" })

-- 打开nvchad config.lua
create_cmd("DeNvchadConfig", function()
   vim.cmd [[ e $HOME/.config/nvim/lua/custom/config.lua ]]
end, { nargs = "*", desc = "" })

-- 添加一個全屏終端(tab)
-- DeTerm   -> 新建標籤並創建終端
-- DeTerm 1 -> 關閉當前所處的標籤
create_cmd("DeTerm", function(args)
   if args.args ~= "" then
      vim.cmd [[
         lua require("nvchad_ui.tabufline").close_buffer()
         tabc
      ]]
   else
      vim.cmd [[
         tabe
         term
         DeNumber
      ]]
   end
end, { nargs = "*", desc = "" })

-- 是否顯示屏幕竪線
-- DeColorcolumn   -> 開啟 屏幕竪線
-- DeColorcolumn 1 -> 關閉 屏幕竪線
create_cmd("DeColorcolumn", function(args)
   if args.args == "1" then
      vim.cmd [[ highlight ColorColumn guifg=#1e2122 guibg=#1e2122 ]]
   else
      vim.cmd [[ highlight ColorColumn guifg=none guibg=#2c2f30 ]]
   end
end, { nargs = "*", desc = "" })

-- 为游戏项目生产预设文件
-- DeProjectinit $config.game_project_cmd key
create_cmd("DeProjectinit", function(args)
   local c, l = string.gsub(args.args, "^%s*(.-)%s*$", "%1"), ""
   local len, i = utils.table_len(config.game_project_cmd), 0
   local template_path = "$HOME/.config/nvim/lua/custom/template/"
   for k, v in pairs(config.game_project_cmd) do
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

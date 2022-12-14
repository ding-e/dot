------------------------------------
-- 自定義命令
------------------
---@diagnostic disable: lowercase-global, undefined-global

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
-- DeDwmKey   -> 查看dwm快捷鍵
-- DeDwmKey 1 ->
create_cmd("DeDwmKey", function(args)
   if args.args == "1" then
      vim.cmd [[ vsp $HOME/core/software/dwm.win95/config.h ]]
   else
      vim.cmd [[ vsp $HOME/core/software/dwm.win95/config.h ]]
   end
end, { nargs = "*", desc = "" })

-- 添加一個全屏終端(tab)
-- DeTerm   -> 新建標籤並創建終端
-- deTerm 1 -> 關閉當前所處的標籤
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

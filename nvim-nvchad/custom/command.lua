------------------------------------
-- 自定義命令
------------------

-- 顯示/隱藏 行號
-- DeNumber   -> 刪除行號
-- DeNumber 1 -> 顯示行號
vim.api.nvim_create_user_command("DeNumber", function(args)
   if args.args == "1" then
      vim.cmd [[ set number
                 set relativenumber ]]
   else
      vim.cmd [[ set nonumber
                 set norelativenumber ]]
   end
end, { nargs = "*", desc = "" })


-- 查看快捷鍵
-- DeCatkey   -> 查看自定義快捷鍵
-- DeCatkey 1 -> 查看nvchad快捷鍵
vim.api.nvim_create_user_command("DeCatkey", function(args)
   if args.args == "1" then
      vim.cmd [[ vsp $HOME/.config/nvim/lua/core/mappings.lua ]]
   else
      vim.cmd [[ vsp $HOME/.config/nvim/lua/custom/mappings.lua ]]
   end
end, { nargs = "*", desc = "" })


-- 添加一個全屏終端(tab)
-- DeCatkey   -> 查看自定義快捷鍵
-- DeCatkey 1 -> 查看nvchad快捷鍵
vim.api.nvim_create_user_command("DeTerm", function(args)
   if args.args ~= "" then
      -- 關閉當前所處的標籤
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

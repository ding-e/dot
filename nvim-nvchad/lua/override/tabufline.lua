------------------------------------
-- 覆盖nvchad-ui tabufline
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

local api = vim.api
local fn = vim.fn
local g = vim.g

dofile(vim.g.base46_cache .. "tbline")

local txt = require("nvchad.tabufline.utils").txt
local btn = require("nvchad.tabufline.utils").btn
local strep = string.rep
local cur_buf = api.nvim_get_current_buf

-- DINGE
-- local style_buf = require("nvchad.tabufline.utils").style_buf
-- local config = require("nvconfig").ui.tabufline
vim.t.bufs = vim.api.nvim_list_bufs()
local config = { order = require("configs.config").tabufline_order }
local tab_icons = require("configs.icons").tabufline

-- g.toggle_theme_icon = "   "
---------------------------------------------------------- btn onclick functions ----------------------------------------------

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"

vim.cmd [[
   function! TbKillBuf(bufnr,b,c,d) 
        call luaeval('require("nvchad.tabufline").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.cmd "function! TbNewTab(a,b,c,d) \n tabnew \n endfunction"
vim.cmd "function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"
vim.cmd "function! TbCloseAllBufs(a,b,c,d) \n lua require('nvchad.tabufline').closeAllBufs() \n endfunction"
vim.cmd "function! TbToggle_theme(a,b,c,d) \n lua require('base46').toggle_theme() \n endfunction"
vim.cmd "function! TbToggleTabs(a,b,c,d) \n let g:TbTabsToggled = !g:TbTabsToggled | redrawtabline \n endfunction"

-------------------------------------------------------- functions ------------------------------------------------------------

local function getNvimTreeWidth()
   for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
      if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
         return api.nvim_win_get_width(win) + 1
      end
   end
   return 0
end

------------------ DINGE nvchad/tabufline/utils functions ---------------------
local get_opt = api.nvim_get_option_value
local buf_name = api.nvim_buf_get_name
local function filename(str)
   return str:match "([^/\\]+)[/\\]*$"
end
local function new_hl(group1, group2)
   local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(group1)), "fg#")
   local bg = fn.synIDattr(fn.synIDtrans(fn.hlID("Tb" .. group2)), "bg#")
   api.nvim_set_hl(0, group1 .. group2, { fg = fg, bg = bg })
   return "%#" .. group1 .. group2 .. "#"
end
local function gen_unique_name(oldname, index)
   for i2, nr2 in ipairs(vim.t.bufs) do
      if index ~= i2 and filename(buf_name(nr2)) == oldname then
         return fn.fnamemodify(buf_name(vim.t.bufs[index]), ":p:.")
      end
   end
end
local style_buf = function(nr, i)
   -- add fileicon + name

   -- DINGE
   -- local icon = "󰈚"
   local icon = tab_icons.buff

   local is_curbuf = cur_buf() == nr
   local tbHlName = "BufO" .. (is_curbuf and "n" or "ff")

   -- DINGE
   -- local icon_hl = new_hl("DevIconDefault", tbHlName)
   -- local icon_hl = new_hl("DevIconzip", tbHlName)
   -- local icon_hl = new_hl("DevIconvue", tbHlName)

   local name = filename(buf_name(nr))
   name = gen_unique_name(name, i) or name
   name = (name == "" or not name) and " No Name " or name

   -- DINGE
   -- if name ~= " No Name " then
   --    local devicon, devicon_hl = require("nvim-web-devicons").get_icon(name)
   --
   --    if devicon then
   --       icon = devicon
   --       icon_hl = new_hl(devicon_hl, tbHlName)
   --    end
   -- end

   -- padding around bufname; 15= maxnamelen + 2 icon & space + 2 close icon
   local pad = math.floor((23 - #name - 5) / 2)
   pad = pad <= 0 and 1 or pad

   local maxname_len = 15

   name = string.sub(name, 1, 13) .. (#name > maxname_len and ".." or "")
   name = txt(" " .. name, tbHlName)

   -- DINGE
   -- name = strep(" ", pad) .. (icon_hl .. icon .. name) .. strep(" ", pad - 1)
   -- local close_btn = btn(" 󰅖 ", nil, "KillBuf", nr)
   name = strep(" ", pad) .. (icon .. name) .. strep(" ", pad - 1)
   local close_btn = btn(" " .. tab_icons.buff_close .. " ", nil, "KillBuf", nr)

   name = btn(name, nil, "GoToBuf", nr)

   -- modified bufs icon or close icon
   local mod = get_opt("mod", { buf = nr })
   local cur_mod = get_opt("mod", { buf = 0 })

   -- color close btn for focused / hidden  buffers
   -- DINGE
   -- if is_curbuf then
   --   close_btn = cur_mod and txt("  ", "BufOnModified") or txt(close_btn, "BufOnClose")
   -- else
   --   close_btn = mod and txt("  ", "BufOffModified") or txt(close_btn, "BufOffClose")
   -- end
   if is_curbuf then
      close_btn = cur_mod and txt(" " .. tab_icons.buff_modified .. " ", "BufOnModified")
         or txt(close_btn, "BufOnClose")
   else
      close_btn = mod and txt(" " .. tab_icons.buff_modified .. " ", "BufOffModified") or txt(close_btn, "BufOffClose")
   end

   name = txt(name .. close_btn, "BufO" .. (is_curbuf and "n" or "ff"))

   return name
end

------------------------------------- modules -----------------------------------------
local M = {}

local function available_space()
   local str = ""

   for _, key in ipairs(config.order) do
      if key ~= "buffers" then
         str = str .. M[key]()
      end
   end

   local modules = api.nvim_eval_statusline(str, { use_tabline = true })
   return vim.o.columns - modules.width
end

M.treeOffset = function()
   return "%#NvimTreeNormal#" .. strep(" ", getNvimTreeWidth())
end

M.buffers = function()
   local buffers = {}
   local has_current = false -- have we seen current buffer yet?

   for i, nr in ipairs(vim.t.bufs) do
      if ((#buffers + 1) * 23) > available_space() then
         if has_current then
            break
         end

         table.remove(buffers, 1)
      end

      has_current = cur_buf() == nr or has_current
      table.insert(buffers, style_buf(nr, i))
   end

   return table.concat(buffers) .. txt("%=", "Fill") -- buffers + empty space
end

g.TbTabsToggled = 0

M.tabs = function()
   local result, tabs = "", fn.tabpagenr "$"

   if tabs > 1 then
      for nr = 1, tabs, 1 do
         -- DINGE
         -- local tab_hl = "TabO" .. (nr == fn.tabpagenr() and "n" or "ff")
         local tab_hl = "BufO" .. (nr == fn.tabpagenr() and "n" or "ff")
         result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
      end

      -- DINGE
      -- local new_tabtn = btn("  ", "TabNewBtn", "NewTab")
      -- local tabstoggleBtn = btn(" 󰅂 ", "TabTitle", "ToggleTabs")
      -- local small_btn = btn(" 󰅁 ", "TabTitle", "ToggleTabs")
      local new_tabtn = btn(" " .. tab_icons.tab_add .. " ", "TabNewBtn", "NewTab")
      local tabstoggleBtn = btn(" " .. tab_icons.tab_toggle .. " ", "TabTitle", "ToggleTabs")
      local small_btn = btn(" " .. tab_icons.tab_toggle .. " ", "TabTitle", "ToggleTabs")

      return g.TbTabsToggled == 1 and small_btn or new_tabtn .. tabstoggleBtn .. result
   end

   return ""
end

M.btns = function()
   -- DINGE
   -- local toggle_theme = btn(g.toggle_theme_icon, "ThemeToggleBtn", "Toggle_theme")
   -- local closeAllBufs = btn(" 󰅖 ", "CloseAllBufsBtn", "CloseAllBufs")
   local toggle_theme = btn(" " .. tab_icons.theme_toggle .. " ", "ThemeToggleBtn", "Toggle_theme")
   local closeAllBufs = btn(" " .. tab_icons.all_close .. " ", "CloseAllBufsBtn", "CloseAllBufs")

   return toggle_theme .. closeAllBufs
end

-- DINGE
return M

-- return function()
--   local result = {}
--
--   if config.modules then
--     for key, value in pairs(config.modules) do
--       M[key] = value
--     end
--   end
--
--   for _, v in ipairs(config.order) do
--     table.insert(result, M[v]())
--   end
--
--   return table.concat(result)
-- end

------------------------------------
-- 覆盖nvchad-ui statusline
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

local utils = require "nvchad.stl.utils"

-- DINGE
-- local config = require("nvconfig").ui.statusline
-- local sep_style = config.separator_style
-- local default_sep_icons = {
--    default = { left = "", right = "" },
--    round = { left = "", right = "" },
--    block = { left = "█", right = "█" },
--    arrow = { left = "", right = "" },
-- }
-- local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]
local separators = { left = "█", right = "█" }

local sep_l = separators["left"]
local sep_r = separators["right"]

------------------ DINGE nvchad/stl/utils functions ---------------------
local version = vim.version().minor
-- credits to ii14 for str:match func
local utils_file = function()
   -- DINGE
   -- local icon = "󰈚"
   local icon = "F"

   local path = vim.api.nvim_buf_get_name(utils.stbufnr())
   local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"

   -- DINGE
   -- if name ~= "Empty" then
   --    local devicons_present, devicons = pcall(require, "nvim-web-devicons")
   --
   --    if devicons_present then
   --       local ft_icon = devicons.get_icon(name)
   --       icon = (ft_icon ~= nil and ft_icon) or icon
   --    end
   -- end

   return { icon, name }
end
local utils_git = function()
   if not vim.b[utils.stbufnr()].gitsigns_head or vim.b[utils.stbufnr()].gitsigns_git_status then
      return ""
   end

   local git_status = vim.b[utils.stbufnr()].gitsigns_status_dict

   -- DINGE
   -- local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
   -- local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
   -- local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
   -- local branch_name = " " .. git_status.head
   -- ("%#St_lspWarning#" .. " ADDED " .. git_status.added .. "") or ""
   -- ("%#St_lspHints#" .. " CHANGED " .. git_status.changed .. "") or ""
   -- ("%#St_lspError#" .. " REMOVED " .. git_status.removed .. "") or ""
   -- "%#St_lspInfo#" .. " BARANCH " .. git_status.head .. ""
   local added = (git_status.added and git_status.added ~= 0) and (" - ADDED " .. git_status.added) or ""
   local changed = (git_status.changed and git_status.changed ~= 0) and (" - CHANGED " .. git_status.changed) or ""
   local removed = (git_status.removed and git_status.removed ~= 0) and (" - REMOVED " .. git_status.removed) or ""
   local branch_name = "%#St_lspDefault#" .. "BARANCH " .. git_status.head

   return " " .. branch_name .. added .. changed .. removed
end
local utils_lsp_msg = function()
   if version < 10 then
      return ""
   end

   local msg = vim.lsp.status()

   if #msg == 0 or vim.o.columns < 120 then
      return ""
   end

   -- DINGE
   -- local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
   -- local ms = vim.uv.hrtime() / 1e6
   -- local frame = math.floor(ms / 100) % #spinners
   -- return spinners[frame + 1] .. " " .. msg
   return msg
end
local utils_lsp = function()
   -- DINGE
   -- if rawget(vim, "lsp") and version >= 10 then
   --   for _, client in ipairs(vim.lsp.get_clients()) do
   --     if client.attached_buffers[M.stbufnr()] then
   --       return (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
   --     end
   --   end
   -- end
   if rawget(vim, "lsp") then
      for _, client in ipairs(vim.lsp.get_active_clients()) do
         if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
            -- DINGE
            -- return (vim.o.columns > 100 and "%#St_LspStatus#" .. "   LSP ~ " .. client.name .. " ") or "   LSP "
            return (vim.o.columns > 70 and "%#St_LspStatus#" .. "LSP -> " .. client.name .. " ") or "LSP "
            -- return (vim.o.columns > 70 and "%#St_NTerminalMode#" .. "LSP ~ " .. client.name .. " ") or "LSP "
         end
      end
   end

   return ""
end
local utils_diagnostics = function()
   if not rawget(vim, "lsp") then
      return ""
   end

   local err = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.ERROR })
   local warn = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.WARN })
   local hints = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.HINT })
   local info = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.INFO })

   -- DINGE
   -- err = (err and err > 0) and ("%#St_lspError#" .. " " .. err .. " ") or ""
   -- warn = (warn and warn > 0) and ("%#St_lspWarning#" .. " " .. warn .. " ") or ""
   -- hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
   -- info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""
   --
   -- err = (err and err > 0) and ("%#St_lspError#" .. "ERRORS " .. err .. "%#St_gitIcons# - ") or ""
   err = (err and err > 0) and ("%#St_lspError#" .. "ERRORS " .. err .. "%#St_LspStatus# - ") or ""
   warn = (warn and warn > 0) and ("%#St_lspWarning#" .. "WARNINGS " .. warn .. "%#St_LspStatus# - ") or ""
   hints = (hints and hints > 0) and ("%#St_lspHints#" .. "HINTS " .. hints .. "%#St_LspStatus# - ") or ""
   info = (info and info > 0) and ("%#St_lspInfo#" .. "INFO " .. info .. "%#St_LspStatus# - ") or ""

   return " " .. err .. warn .. hints .. info
end

------------------------------------- modules -----------------------------------------
local M = {}

M.mode = function()
   if not utils.is_activewin() then
      return ""
   end

   local modes = utils.modes

   local m = vim.api.nvim_get_mode().mode

   -- DINGE
   -- local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. modes[m][1]

   local current_mode = "%#St_" .. modes[m][2] .. "Mode# " .. modes[m][1]
   local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
   return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
end

M.file = function()
   -- DINGE
   -- local x = utils.file()
   -- local name = " " .. x[2] .. (sep_style == "default" and " " or "")
   local x = utils_file()
   local name = " " .. x[2]

   return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
end

M.git = function()
   -- DINGE
   -- return "%#St_gitIcons#" .. utils.git()
   return "%#St_gitIcons#" .. utils_git()
end

M.lsp_msg = function()
   -- DINGE
   -- return "%#St_LspMsg#" .. utils.lsp_msg()
   return "%#St_LspMsg#" .. utils_lsp_msg()
end

-- DINGE
-- M.diagnostics = utils.diagnostics
M.diagnostics = utils_diagnostics

M.lsp = function()
   -- DINGE
   -- return "%#St_Lsp#" .. utils.lsp()
   return "%#St_Lsp#" .. utils_lsp()
end

M.cwd = function()
   -- DINGE
   -- local icon = "%#St_cwd_icon#" .. "󰉋 "
   local icon = "%#St_cwd_icon#"
   local name = vim.uv.cwd()

   -- DINGE
   -- name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
   name = (name:match "([^/\\]+)[/\\]*$" or name) .. " "

   return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. sep_l .. icon .. name)) or ""
end

-- 时间
M.current_time = function()
   -- local current_time = "%#St_cwd_text#" .. " " .. os.date "%H:%M" .. " "
   -- local current_time = "%#St_NTerminalMode#" .. " " .. os.date "%H:%M" .. " "
   -- local dinge_utils, result = require "utils.func", ""
   -- if not dinge_utils.is_tmux() and dinge_utils.is_macos() then
   --    result = current_time .. result
   -- end
   -- return result
   return "%#St_NTerminalMode#" .. " " .. os.date "%H:%M" .. " "
end

-- DINGE
-- M.cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %p %% "
M.cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#%p%% "
M["%="] = "%="

-- DINGE
-- return function()
--   return utils.generate("default", M)
-- end
return M

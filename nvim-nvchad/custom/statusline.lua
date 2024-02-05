------------------------------------
-- 覆蓋nvchad ui模塊的底部狀態欄
----------------------------------
---@diagnostic disable: lowercase-global, undefined-global

local fn = vim.fn
local config = require("core.utils").load_config().ui.statusline
local sep_style = config.separator_style

local default_sep_icons = {
   default = { left = "", right = " " },
   round = { left = "", right = "" },
   block = { left = "█", right = "█" },
   arrow = { left = "", right = "" },
}

local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]
local sep_r = separators["right"]

local M = {}

M.modes = {
   ["n"] = { "NORMAL", "St_NormalMode" },
   ["no"] = { "NORMAL (no)", "St_NormalMode" },
   ["nov"] = { "NORMAL (nov)", "St_NormalMode" },
   ["noV"] = { "NORMAL (noV)", "St_NormalMode" },
   ["noCTRL-V"] = { "NORMAL", "St_NormalMode" },
   ["niI"] = { "NORMAL i", "St_NormalMode" },
   ["niR"] = { "NORMAL r", "St_NormalMode" },
   ["niV"] = { "NORMAL v", "St_NormalMode" },
   ["nt"] = { "NTERMINAL", "St_NTerminalMode" },
   ["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode" },

   ["v"] = { "VISUAL", "St_VisualMode" },
   ["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
   ["V"] = { "V-LINE", "St_VisualMode" },
   ["Vs"] = { "V-LINE", "St_VisualMode" },
   [""] = { "V-BLOCK", "St_VisualMode" },

   ["i"] = { "INSERT", "St_InsertMode" },
   ["ic"] = { "INSERT (completion)", "St_InsertMode" },
   ["ix"] = { "INSERT completion", "St_InsertMode" },

   ["t"] = { "TERMINAL", "St_TerminalMode" },

   ["R"] = { "REPLACE", "St_ReplaceMode" },
   ["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
   ["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
   ["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
   ["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
   ["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

   ["s"] = { "SELECT", "St_SelectMode" },
   ["S"] = { "S-LINE", "St_SelectMode" },
   [""] = { "S-BLOCK", "St_SelectMode" },
   ["c"] = { "COMMAND", "St_CommandMode" },
   ["cv"] = { "COMMAND", "St_CommandMode" },
   ["ce"] = { "COMMAND", "St_CommandMode" },
   ["r"] = { "PROMPT", "St_ConfirmMode" },
   ["rm"] = { "MORE", "St_ConfirmMode" },
   ["r?"] = { "CONFIRM", "St_ConfirmMode" },
   ["x"] = { "CONFIRM", "St_ConfirmMode" },
   ["!"] = { "SHELL", "St_TerminalMode" },
}

M.mode = function()
   local m = vim.api.nvim_get_mode().mode

   -- 删除图标
   -- local current_mode = "%#" .. M.modes[m][2] .. "#" .. "  " .. M.modes[m][1]
   local current_mode = "%#" .. M.modes[m][2] .. "#" .. " " .. M.modes[m][1]

   local mode_sep1 = "%#" .. M.modes[m][2] .. "Sep" .. "#" .. sep_r

   return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
end

M.fileInfo = function()
   -- local icon = " 󰈚 "
   local icon = " F "
   local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:t"

   if filename ~= "Empty " then
      -- 删除图标
      -- local devicons_present, devicons = pcall(require, "nvim-web-devicons")
      --
      -- if devicons_present then
      --    local ft_icon = devicons.get_icon(filename)
      --    icon = (ft_icon ~= nil and " " .. ft_icon) or ""
      -- end
      --
      -- filename = " " .. filename .. " "
      filename = "" .. filename .. " "
   end

   return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. sep_r
end

M.git = function()
   if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
      return ""
   end

   local git_status = vim.b.gitsigns_status_dict

   -- 删除图标
   -- local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
   -- local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
   -- local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
   -- local branch_name = "  " .. git_status.head

   -- ("%#St_lspWarning#" .. " ADDED " .. git_status.added .. "") or ""
   -- ("%#St_lspHints#" .. " CHANGED " .. git_status.changed .. "") or ""
   -- ("%#St_lspError#" .. " REMOVED " .. git_status.removed .. "") or ""
   -- "%#St_lspInfo#" .. " BARANCH " .. git_status.head .. ""
   local added = (git_status.added and git_status.added ~= 0) and (" - ADDED " .. git_status.added .. "") or ""
   local changed = (git_status.changed and git_status.changed ~= 0) and (" - CHANGED " .. git_status.changed .. "") or ""
   local removed = (git_status.removed and git_status.removed ~= 0) and (" - REMOVED " .. git_status.removed .. "") or ""
   local branch_name = " BARANCH " .. git_status.head .. ""

   return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
end

-- LSP STUFF
M.LSP_progress = function()
   if not rawget(vim, "lsp") or vim.lsp.status then
      return ""
   end

   local Lsp = vim.lsp.util.get_progress_messages()[1]

   if vim.o.columns < 120 or not Lsp then
      return ""
   end

   if Lsp.done then
      vim.defer_fn(function()
         vim.cmd.redrawstatus()
      end, 1000)
   end

   local msg = Lsp.message or ""
   local percentage = Lsp.percentage or 0
   local title = Lsp.title or ""

   -- 删除图标
   -- local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
   -- local ms = vim.loop.hrtime() / 1000000
   -- local frame = math.floor(ms / 120) % #spinners
   -- local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
   local content = string.format(" %s %s (%s%%%%) ", title, msg, percentage)

   if config.lsprogress_len then
      content = string.sub(content, 1, config.lsprogress_len)
   end

   return ("%#St_LspProgress#" .. content) or ""
end

M.LSP_Diagnostics = function()
   if not rawget(vim, "lsp") then
      return ""
   end

   local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
   local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
   local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
   local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

   -- 删除图标
   -- errors = (errors and errors > 0) and ("%#St_lspError#" .. " " .. errors .. " ") or ""
   -- warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. "  " .. warnings .. " ") or ""
   -- hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
   -- info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""
   errors = (errors and errors > 0) and ("%#St_lspError#" .. "ERRORS " .. errors .. "%#St_gitIcons# - ") or ""
   warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. "WARNINGS " .. warnings .. "%#St_gitIcons# - ") or ""
   hints = (hints and hints > 0) and ("%#St_lspHints#" .. "HINTS " .. hints .. "%#St_gitIcons# - ") or ""
   info = (info and info > 0) and ("%#St_lspInfo#" .. "INFO " .. info .. "%#St_gitIcons# - ") or ""

   return errors .. warnings .. hints .. info
end

M.LSP_status = function()
   if rawget(vim, "lsp") then
      for _, client in ipairs(vim.lsp.get_active_clients()) do
         if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
            -- 删除图标
            -- return (vim.o.columns > 100 and "%#St_LspStatus#" .. "   LSP ~ " .. client.name .. " ") or "   LSP "
            return (vim.o.columns > 70 and "%#St_LspStatus#" .. "LSP ~ " .. client.name .. " ") or "LSP "
         end
      end
   end
end

-- 时间
M.current_time = function()
   local current_time = "%#St_cwd_text#" .. " " .. os.date "%H:%M" .. " "

   local utils, result = require "custom.utils", ""
   if not utils.is_tmux() and utils.is_macos() then
      result = current_time .. result
   end
   return result
end

M.cwd = function()
   -- 删除图标
   -- local dir_icon = "%#St_cwd_icon#" .. "󰉋 "
   -- local dir_name = "%#St_cwd_text#" .. " " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
   local dir_icon = "%#St_cwd_icon#" .. fn.fnamemodify(fn.getcwd(), ":t")
   local dir_name = " "

   -- return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. sep_l .. dir_icon .. dir_name)) or ""
   local result = (vim.o.columns > 120 and ("%#St_cwd_sep#" .. sep_l .. dir_icon .. dir_name)) or ""
   return result
end

M.cursor_position = function()
   -- 删除图标
   -- local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "
   local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#"

   local current_line = fn.line "."
   local total_line = fn.line "$"
   local text = math.modf((current_line / total_line) * 100) .. tostring "%%"
   text = string.format("%4s", text)

   text = (current_line == 1 and "Top") or text
   text = (current_line == total_line and "Bot") or text

   -- 删除图标
   -- return left_sep .. "%#St_pos_text#" .. " " .. text .. " "
   return left_sep .. text .. " "
end

M.get_modules_arr = function ()
   return {
      M.mode(),
      M.fileInfo(),
      M.git(),
    
      "%=",
      M.LSP_progress(),
      "%=",
    
      M.LSP_Diagnostics(),
      M.LSP_status() or "",
      M.current_time(),
      M.cwd(),
      M.cursor_position(),
   }
end

-- M.run = function()
--    local modules = {
--       M.mode(),
--       M.fileInfo(),
--       M.git(),

--       "%=",
--       M.LSP_progress(),
--       "%=",

--       M.LSP_Diagnostics(),
--       M.LSP_status() or "",
--       M.cwd(),
--       M.cursor_position(),
--    }

--    if config.overriden_modules then
--       config.overriden_modules(modules)
--    end

--    return table.concat(modules)
-- end

return M

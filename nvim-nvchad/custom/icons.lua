------------------------------------
-- 自定義ui模塊/ui插件 圖標
----------------------------

local M = {}

M.tabufline = {
   --             { none,    file  }
   -- 如果buff[2] == devicons, 則使用nvchad默認的圖標
   buff         = { "Ғ",     "Ғ" },
   buff_close   = { "☓",     "☓" },
   tab_close    = { "K",     "K" },
   tab_add      = { "+",     "+" },
   tab_toggle   = { "ℷ",     "<" },
   theme_toggle = { "Ƚ",     "☻" },
   all_close    = { "CLOSE", "CLOSE" },
}

M.statusline = { }

-- է ᴌ Է ℶ ⵃ ℷ λ
-- ↓ → ↧ ↦ ↴ ↳
-- ☓ Ƚ Ғ ғ Қ қ ᴋ K
-- ⁻ ⁺ - + ‣ ‧ ↼
-- ◦ • ▪ ▫ ◉ ◊ ○ ◌
-- ● ◐ ◑ ◒ ◓ ◔ ◕ ◖ ◗
-- ☻ ☽ ☾ ❛ ❜ ♯  
M.nvimtree = {
   --                    { none,   file }
   file_default        = { "F",    "" },
   symlink             = { "L",    "" },
   symlink_arrow       = { " -> ", " -> " },

   folder_default      = { "D",    "D" },
   folder_empty        = { "D",    "D" },
   folder_empty_open   = { "D",    "D" },
   folder_open         = { "D",    "D" },
   folder_symlink      = { "L",    "L" },
   folder_symlink_open = { "L",    "L" },
   folder_arrow_open   = { "",    "", },
   folder_arrow_closed = { "",    "" },

   git_unstaged        = { "✗",    "✗" },
   git_staged          = { "✓",    "✓" },
   git_unmerged        = { "",    "" },
   git_renamed         = { "➜",    "➜" },
   git_untracked       = { "★",    "★" },
   git_deleted         = { "",    "" },
   git_ignored         = { "◌",    "◌" },
}

M.gitsigns = {
   --             { none,   file }
   add          = { "│",    "│" },
   change       = { "│",    "│" },
   delete       = { "D",    "" },
   topdelete    = { "‾",    "‾" },
   changedelete = { "~",    "~" },
}

M.lspkind = {
   Namespace     = "",
   Text          = " ",
   Method        = " ",
   Function      = " ",
   Constructor   = " ",
   Field         = "ﰠ ",
   Variable      = " ",
   Class         = "ﴯ ",
   Interface     = " ",
   Module        = " ",
   Property      = "ﰠ ",
   Unit          = "塞 ",
   Value         = " ",
   Enum          = " ",
   Keyword       = " ",
   Snippet       = " ",
   Color         = " ",
   File          = " ",
   Reference     = " ",
   Folder        = " ",
   EnumMember    = " ",
   Constant      = " ",
   Struct        = "פּ ",
   Event         = " ",
   Operator      = " ",
   TypeParameter = " ",
   Table         = "",
   Object        = " ",
   Tag           = "",
   Array         = "[]",
   Boolean       = " ",
   Number        = " ",
   Null          = "ﳠ",
   String        = " ",
   Calendar      = "",
   Watch         = " ",
   Package       = "",
   Copilot       = " ",
}

return M

------------------------------------
-- 自定義ui模塊/ui插件 圖標
----------------------------
---@diagnostic disable: lowercase-global, undefined-global

local M = {}

M.tabufline = {
   buff          = "Ғ",
   buff_close    = "☓",
   buff_modified = "",
   tab_close     = "K",
   tab_add       = "+",
   tab_toggle    = "TABS", -- ℷ
   theme_toggle  = "T",    -- ☻
   all_close     = "CLOSE",
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
   file_default        = "F",
   symlink             = "L",
   symlink_arrow       = " -> ",

   folder_default      = "D",
   folder_empty        = "D",
   folder_empty_open   = "D",
   folder_open         = "D",
   folder_symlink      = "L",
   folder_symlink_open = "L",
   folder_arrow_open   = "",
   folder_arrow_closed = "",

   git_unstaged        = "✗",
   git_staged          = "✓",
   git_unmerged        = "",
   git_renamed         = "➜",
   git_untracked       = "★",
   git_deleted         = "",
   git_ignored         = "◌",
}

M.gitsigns = {
   add          = "│",
   change       = "│",
   -- delete       = "D",
   delete       = "│",
   topdelete    = "‾",
   changedelete = "~",
   untracked    = "┆",
}

M.devicons = {
   nim = {
      -- icon = "",
      icon = "",
      color = "#f3d400",
      cterm_color = "220",
      name = "Nim",
   },

   nimble = {
      -- icon = "",
      icon = "",
      color = "#f3d400",
      cterm_color = "220",
      name = "Nimble",
   },
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


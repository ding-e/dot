local M = {}

M.base_30 = {
   -- white = "#c7b89d",
   white = "#ffffff",

   darker_black = "#1a1d1e",
   black = "#1e2122", --  nvim bg
   black2 = "#242728",
   one_bg = "#282b2c",
   one_bg2 = "#393c3d",
   one_bg3 = "#404344",
   grey = "#484b4c",
   grey_fg = "#575a5b",
   grey_fg2 = "#545758",
   light_grey = "#606364",
   red = "#ec6b64",
   baby_pink = "#ce8196",
   pink = "#ff75a0",
   line = "#323536", -- for lines like vertsplit
   green = "#89b482",
   vibrant_green = "#a9b665",
   nord_blue = "#6f8faf",
   blue = "#6d8dad",
   yellow = "#d6b676",
   sun = "#d1b171",
   purple = "#9385b4",
   dark_purple = "#887aa9",
   teal = "#749689",
   orange = "#e78a4e",
   cyan = "#82b3a8",
   statusline_bg = "#222526",
   lightbg = "#2d3031",
   pmenu_bg = "#89b482",
   folder_bg = "#6d8dad",
}

M.base_16 = {
   -- 默认背景
   base00 = "#1e2122",
   -- 较浅的背景（用于状态栏、行号和折叠标记）
   base01 = "#2c2f30",
   -- 选择背景
   base02 = "#36393a",
   -- 评论，隐形，线条突出显示
   base03 = "#404344",

   -- 深色前景（用于状态栏）
   base04 = "#d4be98",
   -- 默认前景，插入符号，分隔符，运算符
   base05 = "#eeeef5",
   -- 浅色前景（不经常使用）
   base06 = "#f3f3fa",
   -- 浅色背景（不经常使用）
   base07 = "#c7b89d",

   -- 变量、XML 标记、标记链接文本、标记列表、差异已删除
   base08 = "#F8F8FF",
   -- 整数、布尔值、常量、XML 属性、标记链接网址
   base09 = "#6d8dad",
   -- 类、标记粗体、搜索文本背景
   base0A = "#FFC552",

   -- 字符串、继承的类、标记代码、插入的差异
   base0B = "#a9b665",
   -- 支持、正则表达式、转义字符、标记引号
   base0C = "#B4B4B9",
   -- 函数、方法、属性 ID、标题
   base0D = "#F8F8FF",

   -- 关键字，存储，选择器，标记斜体，差异已更改
   base0E = "#FFC552",
   -- 已弃用，打开/关闭嵌入式语言标记
   base0F = "#DFDFE5",

   -- #e0c080 #7daea3 #8BCCBF #d3869b #BFDAFF
   base0DINGE = "#d6b676",
   base0DINGE2 = "#FFC552",
}

M.polish_hl = {
   Statement           = { fg = M.base_16.base0A     },
   Type                = { fg = M.base_16.base0DINGE },
   Include             = { fg = M.base_16.base0A     },
   Keyword             = { fg = M.base_16.base0A     },
   Special             = { fg = M.base_16.base0A     },
   Constant            = { fg = M.base_16.base09     },

   Delimiter           = { fg = M.base_16.base0A     },
   Character           = { fg = M.base_16.base0A     },

   Macro               = { fg = M.base_16.base0A     },
   Structure           = { fg = M.base_16.base0A     },
   Exception           = { fg = M.base_16.base0A     },

   DINGE_HL_OPERATOR   = { fg = M.base_16.base0A     },
   DINGE_HL_KEYWORD    = { fg = M.base_16.base0A     },
   DINGE_HL_NUMBER     = { fg = M.base_16.base09     },

   -- Operator            = { fg = M.base_16.base0DINGE },
   -- Function            = { fg = M.base_16.base0A     },
   -- Number              = { fg = M.base_16.base0DINGE },
   -- Typedef             = { fg = M.base_16.base0D },
}

vim.opt.bg = "dark"
-- M = require("base46").override_theme(M, "gruvchad")
return M

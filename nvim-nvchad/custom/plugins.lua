------------------------------------
-- 插件添加/覆蓋/移除/禁用
------------------------------
---@diagnostic disable: lowercase-global, undefined-global

-- Awesome plugins for Neovim
-- https://nvimluau.dev

require "custom.function"
local config = require "custom.config"

return {
   -----------------------------------------------------
   -- 覆盖nvchad插件
   -----------------------------
   -- ["lukas-reineke/indent-blankline.nvim"] = false,

   -- leader快捷键菜单
   ["folke/which-key.nvim"] = { disable = false },

   ["nvim-tree/nvim-tree.lua"] = {
      after = { "ui", "nvim-web-devicons" },
      override_options = set_nvimtree(),
   },

   ["nvim-tree/nvim-web-devicons"] = {
      after = "ui",
      module = "nvim-web-devicons",
      config = function()
         set_devicons()
      end,
   },

   ["lewis6991/gitsigns.nvim"] = {
      ft = "gitcommit",
      setup = function()
         require("core.lazy_load").gitsigns()
      end,
      config = function()
         set_gitsigns()
      end,
   },

   ["NvChad/ui"] = { override_options = set_ui() },
   ["NvChad/nvterm"] = { override_options = set_nvterm() },
   ["NvChad/base46"] = {
      config = function()
         set_base46()
      end,
   },

   ["neovim/nvim-lspconfig"] = {
      config = function()
         require "plugins.configs.lspconfig"
         require "custom.lspconfig"
      end,
   },

   ["williamboman/mason.nvim"] = {
      override_options = { ensure_installed = config.mason_list },
   },

   ["nvim-treesitter/nvim-treesitter"] = {
      override_options = { ensure_installed = config.sitter_list },
      -- config = function()
      --    -- 关闭保存自动格式化
      --    -- leader+fm 格式化
      --    vim.g.zig_fmt_autosave = 0
      -- end,
   },

   -----------------------------------------------------
   -- 新装插件
   -----------------------------

   -- 仪表盘
   -- vim.g.startify_session_dir = "$HOME/.config/nvim/session/"
   ["mhinz/vim-startify"] = {},
   -- ["goolord/alpha-nvim"] = { disable = false },

   -- session / workspace
   -- folke/persistence.nvim
   -- 如果當前bur list, 沒有打開buf, 則不保存
   -- 在nvchad打開Startify的時候,馬上關閉(目前buf list數量為0), 則不保存session
   ["ding-e/persistence.nvim"] = { config = set_session() },
   -- ["Shatur/neovim-session-manager"] = {
   --    -- after = { "ui", "nvim-web-devicons" },
   --    -- setup = function() end,
   --    config = set_neovim_session()
   -- },

   -- mac下自动切换输入法
   ["ybian/smartim"] = {
      -- 忽略updates/syncs
      -- lock = true,
      commit = "d73dc7b361966762d74254a1ba52d29dd83d5fd3",
      config = function()
         -- https://blog.51cto.com/u_15273875/3858820
         vim.g.smartim_default = "com.apple.keylayout.ABC"
      end,
   },

   -- 類似vscode的禪模式 - 暂时隐藏状态栏、缓冲线等。
   ["folke/zen-mode.nvim"] = { config = set_zenmode() },
   ["Pocco81/truezen.nvim"] = { config = set_truezen() },

   -- 加速jk
   -- vim.g.accelerated_jk_acceleration_limit = 300
   ["rhysd/accelerated-jk"] = {},

   -- 平滑滚动 <C-u>, <C-d>, <C-b>, <C-f>, <C-y>, <C-e>, zt, zz, zb
   ["karb94/neoscroll.nvim"] = {
      config = function()
         local present, neoscroll = pcall(require, "neoscroll")
         if not present then
            return
         end

         neoscroll.setup()
      end,
   },

   -- editor config - .editorconfig
   -- https://editorconfig.org
   -- ["editorconfig/editorconfig-vim"] = {},
   ["gpanders/editorconfig.nvim"] = {},

   -- 歷史修改紀錄
   -- https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim
   ["mbbill/undotree"] = { config = set_undotree() },

   -- 翻译
   -- ["uga-rosa/translate.nvim"] = {
   --    config = function()
   --       require("translate").setup {
   --          defalut = {
   --             command = "deepl_free",
   --             output = "floating",
   --          },
   --          preset = {
   --             output = {
   --                insert = {
   --                   base = "top",
   --                   off = -1,
   --                },
   --             },
   --          },
   --       }
   --    end,
   -- },

   -- 格式化
   ["jose-elias-alvarez/null-ls.nvim"] = {
      -- disable = true,
      after = "nvim-lspconfig",
      config = function()
         set_nullls()
      end,
   },

   -- 符號對齊
   ["junegunn/vim-easy-align"] = {},

   -- godot gdscript
   ["habamax/vim-godot"] = {},

   -- ["leafo/moonscript-vim"] = {},
   -- ["svermeulen/nvim-moonmaker"] = {},

   -- zig language
   -- tree-sitter - TSInstall zig
   -- ["ding-e/zig-highlight-enhanced"] = { after = "zig.vim" },
   ["$HOME/.config/nvim/lua/custom/plugins/zig-highlight"] = { after = "zig.vim" },
   ["ziglang/zig.vim"] = {
      config = function()
         -- 关闭保存自动格式化
         -- leader+fm 格式化
         vim.g.zig_fmt_autosave = 0
      end,
   },

   -- nim language
   -- 只代码高亮，配合nimlsp代码提示
   -- ["ding-e/nim-highlight"] = {},
   -- ['baabelfish/nvim-nim'] = {},
   -- ['alaviss/nim.nvim'] = {},
   -- ['wsdjeg/vim-nim'] = {},
   -- ['zah/nim.vim'] = {},

   -- ========================================================================

   -- 在命令行下显示缓冲区列表
   -- ["bling/vim-bufferline"] = {},

   -- 如果你在一个分割中打开了两个缓冲区，
   -- 并且你想要关闭一个缓冲区，那么你可以使用:bd命令。
   -- 不幸的是，这个命令也关闭了分割。
   -- 通常，你不想关闭分割，而只想关闭缓冲区。
   -- 在这种情况下，使用Buffkill的:BD命令，
   -- 该命令将关闭缓冲区，但保留分割。
   -- ["qpkorr/vim-bufkill"] = {
   --   config = function ()
   --     -- Turn off default <leader>bb, <leader>bd, etc. mappings (default: 1)
   --     vim.g.BufKillCreateMappings = 1
   --
   --     -- Override default <C-^> behavior for swapping between alternate buffers (default: 0)
   --     -- vim.g.BufKillOverrideCtrlCaret = 1
   --
   --     -- Modify the command prefix if it conflicts with other plugins
   --     -- The below changes BD to DD, BB to DB, etc. (default: 'B')
   --     -- vim.g.BufKillCommandPrefix = 'D'
   --
   --     -- If the buffer you want to kill is in many windows, the following option governs what to do
   --     -- (default: 'confirm', options: 'confirm'/'kill'/'cancel')
   --     -- vim.g.BufKillActionWhenBufferDisplayedInAnotherWindow = 'kill'
   --
   --   end
   -- },

   -- 多光标
   -- ["mg979/vim-visual-multi"] = {
   --   keys = "<C-n>",
   -- },

   -- 增删改引号
   -- ["tpope/vim-surround"] = {
   --   keys = {"c", "d", "S"},
   -- },

   -- 快速选中
   -- ["gcmt/wildfire.vim"] = {
   --   keys = "<CR>",
   -- },

   -- 代码格式化
   -- ["Chiel92/vim-autoformat"] = {
   --   cmd = "Autoformat",
   -- },

   -- 快速分析启动时间
   -- ["dstein64/vim-startuptime"] = {
   --   cmd = "StartupTime",
   -- },

   -- 编辑只读文件
   -- ["lambdalisue/suda.vim"] = {
   --   cmd = "SudaWrite",
   -- },

   -- 现代任务系统
   -- ["skywind3000/asynctasks.vim"] = {
   --   requires = "skywind3000/asyncrun.vim",
   --   cmd = {"AsyncTask", "AsyncTaskEdit"},
   --   opt = true
   -- },

   -- 函数列表
   -- ["liuchengxu/vista.vim"] = {
   --   cmd = "Vista",
   -- },

   -- markdown预览
   -- ["iamcco/markdown-preview.nvim"] = {
   --   run = "cd app && yarn install",
   --   ft = "markdown",
   -- },

   -- 制作markdown表格
   -- ["dhruvasagar/vim-table-mode"] = {
   --   cmd = "TableModeToggle",
   -- },
}

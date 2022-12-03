------------------------------------
-- 插件添加/覆蓋/移除/禁用
------------------------------

require "custom.function"
local overrides = require "custom.override"

return {

   -- ---------------------------------------------------
   -- 移除插件
   -- ---------------------------

   -- ["lukas-reineke/indent-blankline.nvim"] = false,

   -- ---------------------------------------------------
   -- 覆盖nvchad插件
   -- ---------------------------

   -- leader快捷键菜单
   ["folke/which-key.nvim"] = { disable = false },

   -- 自定义lsp配置
   ["neovim/nvim-lspconfig"] = {
      config = function()
         require "plugins.configs.lspconfig"
         require "custom.lspconfig"
      end,
   },

   ["williamboman/mason.nvim"] = {
      override_options = {
         -- 一些默認安裝的lsp
         ensure_installed = {
            "lua-language-server",
            "rust-analyzer",
            "clangd",
         },
      },
   },

   ["nvim-treesitter/nvim-treesitter"] = {
      override_options = {
         -- 一些默認安裝的語法高亮
         ensure_installed = {
            "lua",
            "rust",
            "c",
            "toml",
            "json",
         },
      },
   },

   ["NvChad/ui"] = {
      override_options = overrides.ui,
   },

   ["kyazdani42/nvim-web-devicons"] = {
      after = "ui",
      module = "nvim-web-devicons",
      config = function()
         set_devicons()
      end,
   },

   -- git stuff
   ["lewis6991/gitsigns.nvim"] = {
      ft = "gitcommit",
      setup = function()
         require("core.lazy_load").gitsigns()
      end,
      config = function()
         set_gitsigns()
      end,
   },

   ["NvChad/nvterm"] = {
      override_options = overrides.nvterm,
   },

   ["kyazdani42/nvim-tree.lua"] = {
      after = { "ui", "nvim-web-devicons" },
      override_options = overrides.nvimtree,
   },

   ["NvChad/base46"] = {
      config = function()
         set_base46()
      end,
   },

   -- ---------------------------------------------------
   -- 新装插件
   -- ---------------------------

   -- 仪表盘
   ["mhinz/vim-startify"] = {},

   -- 仪表盘
   -- ["goolord/alpha-nvim"] = { disable = false },

   -- mac下自动切换输入法
   ["ybian/smartim"] = {
      config = function()
         -- https://blog.51cto.com/u_15273875/3858820
         vim.g.smartim_default = "com.apple.keylayout.ABC"
      end,
   },

   -- NeoVim 的焦点模式- 類似vscode的禪模式 - 暂时隐藏状态栏、缓冲线等。
   ["Pocco81/truezen.nvim"] = {
      config = function()
         set_truezen()
      end,
   },

   -- 加速jk
   ["rhysd/accelerated-jk"] = {
      config = function()
         -- vim.g.accelerated_jk_acceleration_limit = 300
      end,
   },

   -- 平滑滚动 <C-u>, <C-d>, <C-b>, <C-f>, <C-y>, <C-e>, zt, zz, zb
   ["karb94/neoscroll.nvim"] = {
      config = function()
         require("neoscroll").setup()
      end,
   },

   -- 符號對齊
   ["junegunn/vim-easy-align"] = {
      config = function() end,
   },

   -- editor config - .editorconfig
   -- https://editorconfig.org
   -- ["editorconfig/editorconfig-vim"] = {},
   ["gpanders/editorconfig.nvim"] = {},

   -- zig language
   -- tree-sitter - TSInstall zig
   ["ziglang/zig.vim"] = {
      config = function()
         -- 关闭保存自动格式化
         -- leader+fm 格式化
         vim.g.zig_fmt_autosave = 0
      end,
   },
   ["ding-e/zig-highlight-enhanced"] = {
      after = "zig.vim",
   },

   -- nim language
   -- 只代码高亮，配合nimlsp代码提示
   ["ding-e/nim-highlight"] = {
      config = function() end,
   },
   -- ['baabelfish/nvim-nim'] = {},
   -- ['alaviss/nim.nvim'] = {},
   -- ['wsdjeg/vim-nim'] = {},
   -- ['zah/nim.vim'] = {},

   -- session / workspace
   ["Shatur/neovim-session-manager"] = {
      -- module = "nvim-tree.lua",
      -- after = { "ui", "nvim-web-devicons" },
      -- setup = function() end,
      config = function()
         set_session()
      end,
   },

   -- 格式化
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         -- require("custom.plugins.null-ls").setup()
         local null_ls = require "null-ls"
         local b = null_ls.builtins
         -- 具体支持语言
         -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
         local sources = {
            -- lua
            b.formatting.stylua,
            -- b.diagnostics.luacheck.with { extra_args = { "--global vim" } },
            -- zig
            b.formatting.zigfmt,
            -- nim
            b.formatting.nimpretty,
            -- clang
            b.formatting.clang_format.with { extra_args = { "--style", "{IndentWidth: 4}" } },
         }
         null_ls.setup { debug = true, sources = sources }
      end,
   },

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

   -- 历史修改记录
   -- ["mbbill/undotree"] = {
   --   opt = true,
   --   cmd = "UndotreeToggle",
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

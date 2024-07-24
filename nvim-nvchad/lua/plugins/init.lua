------------------------------------
-- lazy加载plugin
---------------------------
---@diagnostic disable: lowercase-global, undefined-global

local config = require "configs.config"
local utils = require "utils.func"
require "configs.plugins"

local plugins = {
   {
      "stevearc/conform.nvim",
      enabled = false,
      -- event = 'BufWritePre', -- uncomment for format on save
      config = function()
         require "configs.conform"
      end,
   },

   -- leader快捷键菜单
   {
      "folke/which-key.nvim",
      enabled = true,
   },

   {
      "nvim-tree/nvim-tree.lua",
      opts = set_nvimtree_opt(),
   },
   {
      "nvim-tree/nvim-web-devicons",
      opts = set_devicons_opt(),
   },

   -- {
   --    "NvChad/nvterm",
   --    init = function()
   --       require("core.utils").load_mappings "nvterm"
   --    end,
   --    config = function(_, opts)
   --       set_nvterm(opts)
   --    end,
   -- },

   {
      "neovim/nvim-lspconfig",
      dependencies = {
         -- format & linting
         {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
               set_nullls()
            end,
         },
      },
      config = function()
         require("nvchad.configs.lspconfig").defaults()
         require "configs.lspconfig"
      end, -- Override to setup mason-lspconfig
   },

   {
      "williamboman/mason.nvim",
      opts = { ensure_installed = config.mason_list },
   },
   {
      "nvim-treesitter/nvim-treesitter",
      opts = { ensure_installed = config.treesitter_list },
   },

   -----------------------------------------------------

   -- 启动页
   -- vim.g.startify_session_dir = "$HOME/.config/nvim/session/"
   {
      "mhinz/vim-startify",
      lazy = false,
      config = function()
         -- local name = utils.get_workspace_theme(config.workspace_list, config.theme_toggle)
         -- utils.set_theme(name)
         -- utils.set_theme("dinge")
      end,
   },
   -- ["goolord/alpha-nvim"] = { disable = false },

   -- 缩进
   -- editor config - .editorconfig
   -- https://editorconfig.org
   -- { "gpanders/editorconfig.nvim", lazy = false },
   { "tpope/vim-sleuth", lazy = false },
   {
      "lukas-reineke/indent-blankline.nvim",
      event = "User FilePost",
      opts = {
         indent = { char = "│", highlight = "IblChar" },
         scope = { enabled = false, show_start = true, char = "│", highlight = "IblScopeChar" },
      },
      config = function(_, opts)
         dofile(vim.g.base46_cache .. "blankline")

         local hooks = require "ibl.hooks"
         hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
         require("ibl").setup(opts)

         dofile(vim.g.base46_cache .. "blankline")
      end,
   },

   -- session / workspace
   -- folke/persistence.nvim
   {
      "ding-e/persistence.nvim",
      config = function()
         set_session()
      end,
   },

   -- 禪模式
   {
      "folke/zen-mode.nvim",
      cmd = { "ZenMode" },
      config = function()
         set_zenmode()
      end,
   },
   {
      "Pocco81/truezen.nvim",
      cmd = { "TZAtaraxis", "TZMinimalist", "TZFocus", "TZNarrow" },
      config = function()
         set_truezen()
      end,
   },

   -- 加速jk
   -- vim.g.accelerated_jk_acceleration_limit = 300
   {
      "rhysd/accelerated-jk",
      lazy = false,
   },

   -- 平滑滚动 <C-u>, <C-d>, <C-b>, <C-f>, <C-y>, <C-e>, zt, zz, zb
   {
      "karb94/neoscroll.nvim",
      lazy = false,
      config = function()
         local present, neoscroll = pcall(require, "neoscroll")
         if not present then
            return
         end

         neoscroll.setup {}
      end,
   },

   -- 歷史修改紀錄
   -- https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim
   {
      "mbbill/undotree",
      lazy = false,
      config = function()
         set_undotree()
      end,
   },

   -- 符號對齊
   {
      "junegunn/vim-easy-align",
      lazy = false,
   },

   -- zig language
   -- tree-sitter - TSInstall zig
   -- ["ding-e/zig-highlight-enhanced"] = { after = "zig.vim" },
   {
      "ziglang/zig.vim",
      dependencies = {
         {
            dir = "$HOME/.config/nvim/lua/plugins/zig-highlight",
            lazy = false,
         },
      },
   },

   -- ========================================================================

   -- 多光标
   -- ["mg979/vim-visual-multi"] = {
   --   keys = "<C-n>",
   -- },

   -- 函数列表
   -- ["liuchengxu/vista.vim"] = {
   --   cmd = "Vista",
   -- },
}

if utils.is_macos() then
   local macos_plugins = {
      -- mac下自动切换输入法
      {
         "ybian/smartim",
         -- 忽略updates/syncs
         -- lock = true,
         commit = "d73dc7b361966762d74254a1ba52d29dd83d5fd3",
         lazy = false,
         config = function()
            -- https://blog.51cto.com/u_15273875/3858820
            vim.g.smartim_default = "com.apple.keylayout.ABC"
         end,
      },

      -- godot gdscript
      { "habamax/vim-godot" },
   }

   for _, v in ipairs(macos_plugins) do
      table.insert(plugins, v)
   end
end

return plugins

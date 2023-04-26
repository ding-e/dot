------------------------------------
-- LSP Config
--------------
---@diagnostic disable: lowercase-global, undefined-global

------------------------------
-- 重置lua/ui/lsp.lua设置下的行数中（错误/警告等）代码检查图标
local function lspSymbol(name, icon)
   local hl = "DiagnosticSign" .. name
   vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
lspSymbol("Error", " E")
lspSymbol("Info", " I")
lspSymbol("Hint", " H")
lspSymbol("Warn", " W")
------------------------------

-- local on_attach = require("plugins.configs.lspconfig").on_attach
local on_attach = function(client, bufnr)
   require("plugins.configs.lspconfig").on_attach(client, bufnr)

   -- lsp錯誤信息 - 光標懸停時浮動顯示 - (錯誤信息也可以使用folke/trouble.nvim)
   -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization \
   --                   #show-line-diagnostics-automatically-in-hover-window
   -- vim.api.nvim_create_autocmd("CursorHold", {
   --    buffer = bufnr,
   --    callback = function()
   --       local opts = {
   --          focusable = false,
   --          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
   --          border = "rounded",
   --          source = "always",
   --          prefix = " ",
   --          scope = "cursor",
   --       }
   --       vim.diagnostic.open_float(nil, opts)
   --    end,
   -- })
end
--------------------
-- 禁用lsp错误信息在当前行末显示
-- https://github.com/neovim/nvim-lspconfig/issues/662
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = false,
   signs = true,
   update_in_insert = false,
   underline = true,
})
-------------------------------------

local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "zls" }

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
   }
end

lspconfig.gdscript.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   flags = {
      debounce_text_changes = 150,
   },
   filetypes = { "gd", "gdscript", "gdscript3" },
   -- cmd = {"ncat", "localhost", "6008"}
}

-- nim language
lspconfig.nimls.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   cmd = {
      -- "nimlsp",
      "nimlangserver",
   },
   filetypes = { "nim" },
   root_dir = function(fname)
      return lspconfig.util.root_pattern "*.nimble"(fname) or lspconfig.util.find_git_ancestor(fname)
   end,
   single_file_support = true,
   -- root_dir = lspconfig.util.root_pattern "*.nim",
   -- single_file_support = false,
   on_exit = function(_)
      os.execute "killall nimsuggest"
   end,
   -- on_init = function(_)
   --    local timer = vim.loop.new_timer()
   --    timer:start(
   --       20 * 60 * 1000,
   --       0,
   --       vim.schedule_wrap(function()
   --          timer:close()
   --          vim.cmd [[ LspStop ]]
   --          vim.cmd [[ LspStart ]]
   --       end)
   --    )
   --    -------------------------------------------------------------------------
   --    -- 檢測到nim lsp (nimls) 崩潰, 馬上啟動
   --    -- https://www.reddit.com/r/neovim/comments/uvwdzy/lsp_servers_are_crashing/
   --    -- https://neovim.io/doc/user/lua.html#lua-loop
   --    -- local timer = vim.loop.new_timer()
   --    -- timer:start(
   --    --    2000,
   --    --    2000,
   --    --    vim.schedule_wrap(function()
   --    --       -- 獲取已經啟動的lsp服務
   --    --       -- :lua print(vim.inspect(vim.lsp.get_active_clients()))
   --    --
   --    --       -- 獲取當前buf啟動的lsp服務
   --    --       -- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
   --    --
   --    --       -- 獲取當前buf id
   --    --       -- :lua print(vim.api.nvim_get_current_buf())
   --    --
   --    --       -- 根據lsp id 獲取buf id list
   --    --       -- :lua print(vim.inspect(vim.lsp.get_buffers_by_client_id(5)))
   --    --
   --    --       -- 根據當前buf id 和lsp id 判斷當前buf是否已啟動lsp
   --    --       -- :lua print(vim.lsp.buf_is_attached({bufnr}, {client_id}))
   --    --
   --    --       -- 根據當前buf id 和lsp id 啟動當前buf lsp
   --    --       -- :lua vim.lsp.buf_attach_client({bufnr}, {client_id})
   --    --       -------------------------------------------------------
   --    --       local active_clients = vim.lsp.get_active_clients()
   --    --       -- local buf_clients = vim.lsp.buf_get_clients()
   --    --       local buf_id = vim.api.nvim_get_current_buf()
   --    --       local lsp_names = {}
   --    --       for _, lsp in pairs(active_clients) do
   --    --          table.insert(lsp_names, lsp.name)
   --    --          -- table.insert(lsp_names, lsp.id)
   --    --          if lsp.name == "nimls" and vim.lsp.buf_is_attached(buf_id, lsp.id) == false then
   --    --             vim.notify("啟動當前buf nimlsp", vim.log.levels.WARN)
   --    --             vim.lsp.buf_attach_client(buf_id, lsp.id)
   --    --          end
   --    --       end
   --    --       -- print(vim.inspect(lsp_names))
   --    --       if not vim.tbl_contains(lsp_names, "nimls") then
   --    --          timer:close()
   --    --          vim.notify("啟動nimlsp服務", vim.log.levels.WARN)
   --    --          vim.cmd [[ LspStart nimls ]]
   --    --       end
   --    --    end)
   --    -- )
   -- end,
}

-- c language
lspconfig.clangd.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   cmd = {
      "clangd",
      "--header-insertion=never",
      -- "--background-index",
      -- "--cross-file-rename",
   },
   filetypes = { "c", "cpp", "h", "hpp", "objc" },
   -- rootPatterns = { ".git", "compile_flags.txt", "compile_commands.json" },
   -- handlers = {
   --    ["textDocument/publishDiagnostics"] = vim.lsp.with(
   --       vim.lsp.diagnostic.on_publish_diagnostics, {
   --          virtual_text = true, signs = true, underline = true, update_in_insert = false,
   --       }
   --    ),
   -- },
}

-- rust
lspconfig.rust_analyzer.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   -- handlers = {
   --    ["textDocument/publishDiagnostics"] = vim.lsp.with(
   --       vim.lsp.diagnostic.on_publish_diagnostics, {
   --          virtual_text = false, signs = true, underline = true, update_in_insert = false,
   --       }
   --    ),
   -- },
   -- settings = {
   --    ["rust-analyzer"] = {
   --       imports = { granularity = { group = "module", }, prefix = "self", },
   --       cargo = { buildScripts = { enable = true, }, },
   --       procMacro = { enable = true, },
   --    },
   -- },
}

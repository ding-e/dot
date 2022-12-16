------------------------------------
-- LSP Config
--------------

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

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "zls" }

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
   }
end

-- nim language
lspconfig.nimls.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   cmd = {
      "nimlsp",
   },
   filetypes = { "nim" },
   root_dir = lspconfig.util.root_pattern "*.nim",
   single_file_support = true,
   on_init = function(_)
      -- 檢測到nim lsp (nimls) 崩潰, 馬上啟動
      -- https://www.reddit.com/r/neovim/comments/uvwdzy/lsp_servers_are_crashing/
      -- https://neovim.io/doc/user/lua.html#lua-loop
      local timer = vim.loop.new_timer()
      timer:start(
         2000,
         2000,
         vim.schedule_wrap(function()
            local active_clients = vim.lsp.get_active_clients()
            local lsp_names = {}
            for _, lsp in pairs(active_clients) do
               table.insert(lsp_names, lsp.name)
            end

            if not vim.tbl_contains(lsp_names, "nimls") then
               -- print(vim.inspect(lsp_names))
               vim.notify("nimlsp exits", vim.log.levels.WARN)
               timer:close()

               -- vim.cmd [[ LspStop ]]
               vim.cmd [[ LspStart ]]
            end
         end)
      )
   end,
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
   --    ["textDocument/publishDiagnostics"] =
   --       vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   --          virtual_text = true,
   --          signs = true,
   --          underline = true,
   --          update_in_insert = false,
   --       }),
   -- },
}

-- rust
lspconfig.rust_analyzer.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   -- settings = {
   --    ["rust-analyzer"] = {
   --       imports = {
   --          granularity = {
   --             group = "module",
   --          },
   --          prefix = "self",
   --       },
   --       cargo = {
   --          buildScripts = {
   --             enable = true,
   --          },
   --       },
   --       procMacro = {
   --          enable = true,
   --       },
   --    },
   -- },
}

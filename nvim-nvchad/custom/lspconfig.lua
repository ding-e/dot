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
   root_dir  = lspconfig.util.root_pattern("*.nim"),
   single_file_support = true,
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

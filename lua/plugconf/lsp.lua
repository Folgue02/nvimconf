local mason = require("mason")
local lspconfig = require("lspconfig")

mason.setup({})

lspconfig.crystalline.setup {}
lspconfig.pyright.setup {}
lspconfig.lua_ls.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.jdtls.setup {}
lspconfig.ols.setup {}
lspconfig.gopls.setup {}
lspconfig.tsserver.setup {}
--lspconfig.perlls.setup {}
--lspconfig.perlnavigator.setup {}
lspconfig.perlpls.setup {}
lspconfig.nimls.setup {}
lspconfig.bashls.setup {}


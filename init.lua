-- Lazy stuff
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'wakatime/vim-wakatime',

    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },

    {
        'nvim-lualine/lualine.nvim',
        'archibate/lualine-time',
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },

    "nvim-tree/nvim-tree.lua",

    {
        "nyoom-engineering/nyoom.nvim",
        "Mofiqul/vscode.nvim",
        config = function()
            --vim.cmd [[ colorscheme lunaperche ]]
            vim.cmd [[ colorscheme vscode ]]
        end
    },

    {
        'nvim-treesitter/nvim-treesitter'
    },

    {
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp"
    },

    -- Language specific stuff
    "rust-lang/rust.vim",
    "Tetralux/odin.vim",
    "vim-crystal/vim-crystal",
    "alaviss/nim.nvim",
    "jidn/vim-dbml",
    "rhaiscript/vim-rhai"
})

-- TODO: Fix keymapping not working.
require("plugconf")
require("settings")

-- **=================**
-- |    Keymapping     |
-- **=================**

-- =========
-- TELESCOPE
-- =========
local tc = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', tc.find_files, {})
vim.keymap.set('n', '<leader>fg', tc.live_grep, {})
vim.keymap.set('n', '<leader>fb', tc.buffers, {})

-- =========
-- NVIM-TREE
-- =========

local function on_attach_function(bufnr)
    local api = require("nvim-tree.api")

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "<leader>h", ":NvimTreeOpen<CR>", {})
    vim.keymap.set("n", "<leader>pb", ":NvimTreeCollapse", {})
end



require("nvim-tree").setup {
    on_attach = on_attach_function
}

-- ========
-- NVIM-LSP
-- ========
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, {})

-- ========
-- NVIM-CMP
-- ========
local cmp = require("cmp")
local lsp = require("lspconfig")

-- Capabilities (i.e. auto import)
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.rust_analyzer.setup {
    capabilities = cmp_capabilities
}

-- Make lua snip work
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup {
    window = {
        completion = {
            border = 'rounded',
            scrollbar = '║',
        },
        documentation = {
            border = 'rounded'
        }
    },
    -- Mapping
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
    },

    -- Sources
    sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
    },
    experimental = {
        ghost_text = true
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    }
}
print("Loaded settings")

-- ===========
-- LUALINE-TIME
-- ===========
require('lualine').setup {
    options = {
        theme = 'ayu_mirage',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'ctime'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

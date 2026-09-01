-- ~/.config/nvim/init.lua

-- ===== Startup speed basics =====
vim.loader.enable()  -- byte-compiled module cache, real startup-time win on every launch

-- Disable unused providers so Neovim doesn't spend time checking for them
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0  -- re-enable if you actually use python-based plugins

-- ===== Core options =====
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.termguicolors = true
-- Esc left as default - no jk/jj remap

-- ===== Bootstrap lazy.nvim =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ===== Plugins - every entry below is lazy-loaded on purpose =====
require("lazy").setup({

    -- Theme: loads immediately (priority 1000) since colors are needed
    -- at startup, but this is the ONE deliberate exception
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },

    -- Treesitter: only loads when you actually open a buffer
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua", "yaml", "json", "javascript", "typescript",
                    "bash", "markdown", "toml",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Fuzzy finder: only loads when you press a find/grep keybind
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        },
    },

    -- File tree: only loads on the toggle keybind, never on startup
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "NvimTreeToggle",
        keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" } },
        config = function() require("nvim-tree").setup({}) end,
    },

    -- LSP: Mason itself only loads via its own command, kept out of startup path
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function() require("mason").setup() end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "yamlls", "ansiblels", "ts_ls", "bashls", "lua_ls",
                    "pyright", "ruff", "eslint",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = ok and cmp_lsp.default_capabilities() or nil

            for _, server in ipairs({
                "yamlls", "ansiblels", "ts_ls", "bashls", "lua_ls",
                "pyright", "ruff", "eslint",
            }) do
                lspconfig[server].setup({ capabilities = capabilities })
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        end,
    },

    -- Completion: only loads once you start typing in insert mode
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
            })
        end,
    },

    -- Git signs: only loads once a real file buffer is open
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function() require("gitsigns").setup() end,
    },

    -- Statusline: deferred to VeryLazy (fires after startup, not blocking it)
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({ options = { theme = "catppuccin" } })
        end,
    },

    -- Comment toggling: only loads on the actual keypress
    {
        "numToStr/Comment.nvim",
        keys = { { "gc", mode = { "n", "v" } }, { "gcc" } },
        config = function() require("Comment").setup() end,
    },

    -- Autopairs: only needed once you're typing
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("nvim-autopairs").setup() end,
    },

    -- Keybind hints popup: deferred, not needed at startup
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function() require("which-key").setup() end,
    },

    -- Claude Code IDE integration: WebSocket/MCP protocol, matches the
    -- official VS Code extension's capabilities (diff previews, selection
    -- context, file context injection). Only loads on the toggle keybind.
    {
        "coder/claudecode.nvim",
        cmd = { "ClaudeCode", "ClaudeCodeFocus" },
        keys = {
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
        },
        config = function()
            require("claudecode").setup({})
        end,
    },

    -- Ansible playbook/role filetype detection and syntax highlighting
    -- (complements ansiblels LSP already configured above)
    {
        "pearofducks/ansible-vim",
        ft = { "yaml.ansible", "ansible" },
    },

    -- Python virtualenv picker
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
        ft = "python",
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select venv" },
        },
        config = function() require("venv-selector").setup() end,
    },

    -- Format-on-save: one tool covering Python (ruff), JS/TS (prettier),
    -- Lua (stylua) instead of separate formatter plugins per language
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>cf",
                function() require("conform").format({ async = true, lsp_fallback = true }) end,
                desc = "Format buffer",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff_format" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    yaml = { "prettier" },
                    lua = { "stylua" },
                },
                format_on_save = { timeout_ms = 500, lsp_fallback = true },
            })
        end,
    },
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors=true
vim.g.t_Co=256
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = 'unnamed'
vim.g.vista_default_executive = 'nvim_lsp'
vim.o.showtabline = 2

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { 'mrcjkb/rustaceanvim', version = '^5', lazy = false, },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'tomasr/molokai' },
    { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
    'junegunn/fzf.vim',
    { 'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    'LionC/nest.nvim',
    'nvim-tree/nvim-tree.lua',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'hrsh7th/nvim-cmp',
    'liuchengxu/vista.vim',
	'lewis6991/gitsigns.nvim',
    -- 'airblade/vim-gitgutter',
    'tpope/vim-fugitive',
	'nvim-treesitter/nvim-treesitter',
    { 'j-hui/fidget.nvim', opts = {}, },
    'mfussenegger/nvim-dap',
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require('lualine').setup({
    options = {
        theme = 'onedark',
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
    },
    tabline = {
        lualine_a = {'windows'},
        lualine_z = {'tabs'},
    },
})

vim.cmd [[colorscheme molokai]]

vim.lsp.inlay_hint.enable(true)

function toggleInlayHint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

vim.g.rustfmt_autosave = 1

vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'grn')

local nest = require('nest')
nest.applyKeymaps {
    { '<C-Right>', '<cmd>tabn<CR>' },
    { '<C-Left>', '<cmd>tabp<CR>' },
    { '<esc>', {
        { 't', '<cmd>tabnew<CR>' },
    }},
    { '<S-Down>', '<C-W><C-J>' },
    { '<S-Up>', '<C-W><C-K>' },
    { '<S-Right>', '<C-W><C-L>' },
    { '<S-Left>', '<C-W><C-H>' },
    { '<F9>', '<cmd>Vista!!<CR>' },
    { '<F8>', '<cmd>NvimTreeToggle<CR>' },
    { '<F7>', '<cmd>NvimTreeFindFileToggle<CR>' },
    { '<F6>', '<cmd>lua toggleInlayHint()<CR>' },
    { '<leader>', {
        { 't', {
            { 't', '<cmd>Telescope<CR>' },
            { 'r', '<cmd>Telescope resume<CR>' },
            { 'f', '<cmd>Telescope find_files<CR>' },
            { 'l', '<cmd>Telescope live_grep<CR>' },
            { 'g', {
                { 'b', '<cmd>Telescope git_branches<CR>' },
                { 'c', '<cmd>Telescope git_commits<CR>' },
                { 's', '<cmd>Telescope git_status<CR>' },
            }},
        }},
        { 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>' },
        { 'd', {
            { 'b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>" },
            { 'c', "<cmd>lua require'dap'.continue()<CR>" },
            { 's', "<cmd>lua require'dap'.step_over()<CR>" },
            { 'i', "<cmd>lua require'dap'.step_into()<CR>" },
            { 'r', "<cmd>lua require'dap'.repl.open()<CR>" },
        }},
        -- { 'a', '<cmd>RustLsp codeAction<cr>' },

        -- Lua functions can be right side values instead of key sequences
        -- { 'l', {
        --     { 'c', vim.lsp.buf.code_actions },
        --     { 'r', vim.lsp.buf.rename },
        --     { 's', vim.lsp.buf.signature_help },
        --     { 'h', vim.lsp.buf.hover },
        -- }},
    }},
    { 'g', {
        { 'p', '`[v`]' },
        { 'd', '<cmd>lua vim.lsp.buf.definition()<CR>' },
        { 'D', '<cmd>lua vim.lsp.buf.declaration()<CR>' },
        { 'i', '<cmd>lua vim.lsp.buf.implementation()<CR>' },
        -- { 'r', '<cmd>lua vim.lsp.buf.references()<CR>' },
        { 'r', '<cmd>Telescope lsp_references<CR>' },
        { 'y', '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
        { 's', '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
        { 'l', '<cmd>lua vim.diagnostic.open_float()<CR>' },
    }},

	{ '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>gl' },
	{ ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>gl' },

    { mode = 'i', {
        { '{<cr>', '{<cr>}<esc>O' },
        { '(<cr>', '(<cr>)<esc>O' },
        { '[<cr>', '[<cr>]<esc>O' },
    }},

    { mode = 'v', {
        { '<tab>', '>gv' },
        { '<s-tab>', '<gv' },
    }},
}

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
)
require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['rust_analyzer'].setup {
--   capabilities = capabilities
-- }
require('gitsigns').setup {
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text_pos = 'right_align',
        delay = 100
    },
}

vim.cmd [[
hi SignColumn guibg=NONE
hi GitSignChange guifg=yellow
]]

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
          checkOnSave = {
              enable = true,
              command = 'check',
          },
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

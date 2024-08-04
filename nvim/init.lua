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
vim.g.rehash256 = 1
vim.o.shiftwidth = 4
vim.o.tabstop = 4


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
    { 'jhuni0123/molokai' },
    { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
    'junegunn/fzf.vim',
    { 'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    'NvChad/nvim-colorizer.lua',
    'LionC/nest.nvim',
    'nvim-tree/nvim-tree.lua',
    'neovim/nvim-lspconfig',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
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
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'windwp/nvim-autopairs', event = "InsertEnter", config = true }
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
            { 'b', '<cmd>Telescope buffers<CR>' },
            { 'd', '<cmd>Telescope diagnostics<CR>' },
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
        { '<C-a>', '<ESC>I' },
        { '<C-e>', '<ESC>A' },
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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
-- Set up nvim-cmp.
local lspkind = require('lspkind')
local cmp = require("cmp")
local compare = cmp.config.compare
local types = require('cmp.types')
local kinds_priority = {}
kinds_priority[types.lsp.CompletionItemKind.Text] = 100
kinds_priority[types.lsp.CompletionItemKind.Snippet] = 99
kinds_priority[types.lsp.CompletionItemKind.Field] = 1
kinds_priority[types.lsp.CompletionItemKind.Method] = 1
function compare_kind(entry1, entry2)
    local kind = types.lsp.CompletionItemKind
    local kind1 = entry1:get_kind()
    kind1 = kinds_priority[kind1] or kind1
    local kind2 = entry2:get_kind()
    kind2 = kinds_priority[kind2] or kind2
    if kind1 ~= kind2 then
        local diff = kind1 - kind2
        if diff < 0 then
            return true
        elseif diff > 0 then
            return false
        end
    end
end
local ELLIPSIS_CHAR = '...'
local MAX_MENU_WIDTH = 50

local get_ws = function (max, len)
  return (" "):rep(max - len)
end

local format = function(_, item)
  local menu_content = item.menu or ''
  if #menu_content > MAX_MENU_WIDTH then
    item.menu = vim.fn.strcharpart(menu_content, 0, MAX_MENU_WIDTH) .. ELLIPSIS_CHAR
  end

  return item
end
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
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                     -- can also be a function to dynamically calculate max width such as 
                     -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = format,
    })
  },
  sorting = {
      comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare_kind,
          compare.locality,
          compare.sort_text,
          compare.length,
          compare.order,
      },
  },
  mapping = cmp.mapping.preset.insert({
    ['<PageUp>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 4 }),
    ['<PageDown>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 4 }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 9 },
    -- { name = 'vsnip', priority = 5 }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer', priority = 3 },
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
  matching = { disallow_symbol_nonprefix_matching = false },
})

local hl = vim.api.nvim_set_hl

vim.cmd [[
hi SignColumn guibg=NONE
hi GitSignsChange guifg=yellow
]]

hl(0, 'Pmenu', { bg='#222222', fg='NONE', blend=15 })
hl(0, 'PmenuSel', { bg='#444444', fg='NONE' })
hl(0, 'LspInlayHint', { bg='NONE', fg='#666666', italic=true })
hl(0, 'NormalFloat', { bg='#222222', fg='NONE', blend=15 })

hl(0, 'CmpItemMenu', { bg='NONE', fg='#808080' })
-- gray
hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

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
require 'colorizer'.setup {
    user_default_options = {
	    names = false,
    }
}


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

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

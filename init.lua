local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

require('packer').startup(function()
  use {'wbthomason/packer.nvim'} -- Plugin Manager
  
  use {'ful1e5/onedark.nvim'} -- Theme
  use 'folke/tokyonight.nvim'
  use 'itchyny/lightline.vim'

  -- Nav
  use {
  'phaazon/hop.nvim',
  as = 'hop',
  }

  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'}}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
}

  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-vinegar'}
  -- use {'cohama/lexima.vim'} -- auto close paranthesis, quotes etc
  use {'sbdchd/neoformat'}

  -- LSP + Syntax
  use {'nvim-treesitter/nvim-treesitter'} 
  use {'nvim-treesitter/nvim-treesitter-textobjects'} 
  use {'neovim/nvim-lspconfig'} -- add lsp language config
  use 'hrsh7th/nvim-cmp' -- Autocompletion 
  use 'hrsh7th/cmp-nvim-lsp' -- Source for nvim LSP client
  use 'williamboman/nvim-lsp-installer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use 'kosayoda/nvim-lightbulb' -- lightbulb for code actions


  use 'dstein64/vim-startuptime'
  use 'knubie/vim-kitty-navigator'
end)

vim.opt.expandtab=true -- use spaces
vim.opt.tabstop=2 -- tab = 2 spaces
vim.opt.shiftwidth=2 -- tab size
vim.opt.ignorecase=true -- search ignore case 
vim.opt.smartcase=true -- search case sensitive if capital in search
vim.opt.number=true -- line numbers
vim.opt.relativenumber=true -- relative numbers
vim.opt.scrolloff=1 -- leave space top / bottom
vim.opt.hidden=true -- don't prompt save on changes
vim.opt.cursorline=true -- highlight current line
vim.opt.mouse='a' -- use mouse
vim.opt.breakindent=true -- wrapped lines indented correctly
vim.opt.linebreak=true -- wrap lines at breakpoints
vim.opt.inccommand='nosplit' -- show effect of command incrementally
vim.opt.undofile=true 
vim.opt.completeopt='menu,menuone,noselect'
vim.opt.updatetime=750 -- Update time for page refresh + audo cmd
vim.opt.swapfile=false -- no swap files
vim.opt.splitright=true -- new split on the right
vim.opt.splitbelow=true -- new split on the bottom
-- Theme --
-- vim.g.tokyonight_style = "night"
-- vim.cmd[[colorscheme tokyonight]]
vim.cmd[[colorscheme onedark]]

-- Mapping
vim.api.nvim_set_keymap('', '<Space>', '<Leader>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = false, silent=true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<c-l>', ':nohlsearch<cr> <c-l>', {noremap = false, silent=true}) -- remove search highlights

-- Quickfix List 
-- TODO figure these out (replaced by kitty nav)
-- vim.api.nvim_set_keymap('n', '<c-j>', ':cnext<cr>zz', {noremap = false, silent=true})
-- vim.api.nvim_set_keymap('n', '<c-k>', ':cprev<cr>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>cl', ':ccl<cr>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>co', ':colder<cr>', {noremap = false, silent=true})
-- Location list 
vim.api.nvim_set_keymap('n', '<leader>j', ':lnext<cR>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>k', ':lprev<cR>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>lc', ':lcl<cr>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true }) -- Yank until end of line (is on master 0.6?)

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Git
vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //2<CR>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //3<CR>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Gvdiffsplit!<CR>', {noremap = false, silent=true})
-- Hop
vim.api.nvim_set_keymap('n', 's', ':HopWord<CR>', {noremap = false, silent=true})
-- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})


require'hop'.setup()
require'nvim-tree'.setup{
  disable_netrw = false,
  hijack_netrw = false,
}
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = false, silent=true})

-- LSP
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>fm', ':Neoformat<CR>', opts)

end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

    if server.name == "gopls" then
      opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            buildFlags = {"-tags", "gen"},
          },
        },
      }
    end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- require'lspconfig'.metals.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }


-- Treesitter TODO fix failling downloads
local ts = require('nvim-treesitter.configs')
ts.setup({
  highlight = { enable = true },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  -- rainbow={ enable=true } 
})

-- Telescope 
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
require('telescope').load_extension('fzf')

-- function file_browser()
--   require'telescope.builtin'.file_browser({
--     cwd = '<cmd>utils.buffer_dir()<CR>'
--   })
-- end

-- vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua file_browser()<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope file_browser<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fi', ':Telescope find_files<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope live_grep<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>cm', ':Telescope commands<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>ch', ':Telescope command_history<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope current_buffer_fuzzy_find<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fr', ':Telescope registers<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fk', ':Telescope marks<cr>', {noremap = true, silent=true})
-- lsp telescope
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope lsp_document_symbols<cr>', {noremap = true, silent=true})
-- vim.api.nvim_set_keymap('n', '<leader>ws', ':Telescope lsp_dynamic_workspace_symbols<cr>', {noremap = true, silent=true})


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = function(fallback)
    --   if vim.fn.pumvisible() == 1 then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    --   elseif luasnip.expand_or_jumpable() then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
    --   else
    --     fallback()
    --   end
    -- end,
    -- ['<S-Tab>'] = function(fallback)
    --   if vim.fn.pumvisible() == 1 then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
    --   elseif luasnip.jumpable(-1) then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
    --   else
    --     fallback()
    --   end
    -- end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'relativepath', 'gitbranch', 'modified' } },
    -- right = { { 'percent' } }
  },
  inactive = {
    left = { { 'relativepath' } }
  },
  component_function = { gitbranch = 'fugitive#head' },
}

-- Formatter
vim.api.nvim_exec(
  [[
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
  augroup END
]],
  false
)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)
-- autocmd for lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

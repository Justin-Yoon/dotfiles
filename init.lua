local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

require('packer').startup(function()
  use {'wbthomason/packer.nvim'} -- Plugin Manager
  
  use {'navarasu/onedark.nvim'} -- Theme
  
  -- TODO find out why this is not working
  -- use {'justinmk/vim-sneak'}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'}}}
  use {'tpope/vim-surround'}

  use {'nvim-treesitter/nvim-treesitter'} 
  use {'neovim/nvim-lspconfig'} -- add lsp language config
  use 'hrsh7th/nvim-cmp' -- Autocompletion 
  use 'hrsh7th/cmp-nvim-lsp' -- Source for nvim LSP client
  use {'kabouzeid/nvim-lspinstall'}

end)

vim.opt.expandtab=true -- use spaces
vim.opt.tabstop=2 -- tab = 2 spaces
vim.opt.shiftwidth=2 -- tab size
vim.opt.ignorecase=true -- search ignore case 
vim.opt.smartcase=true -- search case sensitive if capital in search
vim.opt.number=true -- line numbers
vim.opt.scrolloff=1 -- leave space top / bottom
vim.opt.hidden=true -- don't prompt save on changes
vim.opt.mouse='a' -- use mouse
vim.opt.breakindent=true -- wrapped lines indented correctly
vim.opt.linebreak=true -- wrap lines at breakpoints

-- Theme --
require('onedark').setup()

-- Mapping
vim.api.nvim_set_keymap('', '<Space>', '<Leader>', {noremap = false, silent=true})

-- vim.api.vnim_set_keymap map <Space> <Leader>
-- nnoremap <leader>b :ls<CR>:b<Space>

-- LSP
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{ on_attach = on_attach, indent = { enable = true } }
end

-- TODO set up advanced lsp config (lspinstall docs)

-- Treesitter TODO fix failling downloads
local ts = require('nvim-treesitter.configs')
ts.setup({--ensure_installed = 'maintained',
highlight = { enable = true }, rainbow={ enable=true } })

-- Telescope TODO performance enhancements using fzf
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope file_browser<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fi', ':Telescope find_files<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':Telescope live_grep<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>gw', ':Telescope grep_string<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>c', ':Telescope commands<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>gf', ':Telescope current_buffer_fuzzy_find<cr>', {noremap = true, silent=true})

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
   --  expand = function(args)
   --    require('luasnip').lsp_expand(args.body)
   --  end,
  },
  mapping = {
   --  ['<C-p>'] = cmp.mapping.select_prev_item(),
   --  ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
    --  behavior = cmp.ConfirmBehavior.Replace,
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
    -- { name = 'luasnip' },
  },
}

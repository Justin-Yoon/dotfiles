local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

require('packer').startup(function()
  use {'wbthomason/packer.nvim'} -- Plugin Manager
  
  -- UI
  use {'ful1e5/onedark.nvim'} -- Theme
  use 'folke/tokyonight.nvim'
  use 'itchyny/lightline.vim'

  -- Nav
  use {
  'phaazon/hop.nvim',
  as = 'hop',
  }

  -- Telescope
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'}}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  use 'chentoast/marks.nvim'
  -- TODO figure out why this isn't working
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      }
    end
  }

  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-fugitive'}
  use {'kdheepak/lazygit.nvim'}
  use {'tpope/vim-vinegar'}   
  use {'wellle/targets.vim'}   
  use {'windwp/nvim-autopairs'} -- auto close parens
  use {'windwp/nvim-ts-autotag'} -- auto close tags eg <div></div>
  -- use {'romainl/vim-cool'} -- turn off search hl when move
  use {'kevinhwang91/nvim-hlslens'}
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

  -- LSP + Syntax
  use {'nvim-treesitter/nvim-treesitter'} 
  use {'nvim-treesitter/nvim-treesitter-textobjects'} 
  use {'nvim-treesitter/nvim-treesitter-refactor'} -- for highlighting word on page, not using the refactoring
  -- use {'nvim-treesitter/nvim-treesitter-context'}
  use {'neovim/nvim-lspconfig'} -- add lsp language config
  use 'hrsh7th/nvim-cmp' -- Autocompletion 
  use 'hrsh7th/cmp-nvim-lsp' -- Source for nvim LSP client
  use 'williamboman/nvim-lsp-installer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use "rafamadriz/friendly-snippets"
  use "ray-x/lsp_signature.nvim" -- show function signature when typing


  use({ "jose-elias-alvarez/null-ls.nvim", requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  })
  use {
  'abecodes/tabout.nvim',
  config = function()
    require('tabout').setup {}
  end,
	wants = {'nvim-treesitter'}, -- or require if not used so far
	after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
}


  use 'dstein64/vim-startuptime'
  use 'knubie/vim-kitty-navigator'
end)

vim.bo.filetype="on" -- enable plugin for lang specific settings
vim.opt.expandtab=true -- use spaces
vim.opt.tabstop=2 -- tab = 2 spaces
vim.opt.shiftwidth=2 -- tab size
vim.opt.ignorecase=true -- search ignore case 
vim.opt.smartcase=true -- search case sensitive if capital in search
vim.opt.number=true -- line numbers
vim.opt.relativenumber=true -- relative numbers
vim.opt.cursorline=true -- highlight current line
vim.opt.mouse='a' -- use mouse
vim.opt.breakindent=true -- wrapped lines indented correctly
vim.opt.linebreak=true -- wrap lines at breakpoints
vim.opt.inccommand='nosplit' -- show effect of command incrementally
vim.opt.undofile=true 
vim.opt.completeopt='menu,menuone,noselect'
vim.opt.updatetime=300 -- Update time for page refresh + audo cmd
vim.opt.swapfile=false -- no swap files
vim.opt.splitright=true -- new split on the right
vim.opt.splitbelow=true -- new split on the bottom
vim.opt.title=true
vim.opt.titlestring='nvim %{fnamemodify(getcwd(), ":t")}/%f'
-- vim.o.clipboard = 'unnamedplus'
-- Theme --
-- vim.g.tokyonight_style = "night"
-- vim.cmd[[colorscheme tokyonight]]
vim.cmd[[colorscheme onedark]]


-- Mapping
vim.api.nvim_set_keymap('', '<Space>', '<Leader>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = false, silent=true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true, silent=true})
vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', {noremap = true, silent=true})
-- Quickfix List 
-- TODO figure these out (replaced by kitty nav)
vim.api.nvim_set_keymap('n', '<c-n>', ':cnext<cr>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<c-p>', ':cprev<cr>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>cl', ':ccl<cr>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>co', ':colder<cr>', {noremap = false, silent=true})
-- Location list 
vim.api.nvim_set_keymap('n', '<leader>j', ':lnext<cR>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>k', ':lprev<cR>zz', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>lc', ':lcl<cr>', {noremap = false, silent=true})

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- vim.api.nvim_set_keymap('n', 'j', ":nohlsearch<cr>j", { noremap = false, expr = true, silent = true })

-- Git
vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<CR>', {noremap = false, silent=true})
-- vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //2<CR>', {noremap = false, silent=true})
-- vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //3<CR>', {noremap = false, silent=true})
-- vim.api.nvim_set_keymap('n', '<leader>gs', ':Gvdiffsplit!<CR>', {noremap = false, silent=true})
-- Hop
vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = false, silent=true})
vim.api.nvim_set_keymap('', '<C-S>', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = false, silent=true})
vim.api.nvim_set_keymap('', '<C-F>', "<cmd>lua require'hop'.hint_char1({ inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})

-- nvim-hlsens
vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], {noremap = false, silent = true})


require('hlslens').setup({
  calm_down = true,
  nearest_only = true
})

require'hop'.setup()
require'nvim-tree'.setup{
  update_focused_file = {
    enable = true,
  },
}
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', {noremap = false, silent=true})

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
  -- buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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
  buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Telescope
  -- buf_set_keymap('n', 'gr', ':Telescope lsp_references<cr>', opts)
  buf_set_keymap('n', 'gI', ':Telescope lsp_implementations<cr>', opts)

-- TODO remove this when neovim lsp can handle "source.organizeImports"
  function organise_imports() 
    local params = vim.lsp.util.make_range_params(nil, "utf-16")
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1500)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end


  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = organise_imports,
  })
    -- vim.cmd("autocmd BufWritePre *.go lua org_imports(1500)")
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end

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

  if server.name == "tsserver" then
    opts = {
      on_attach = function(client, bufnr)
        -- Disable to make ls-null the default
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    }
  end

  if server.name == "gopls" then
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          buildFlags = {"-tags=windows"},
          -- buildFlags = {"-tags=windows"},
          -- buildFlags = {"-tags=!windows"},
        },
      },
    }
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)


require "lsp_signature".setup()

-- require'lspconfig'.metals.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
-- Null LS
local null_ls = require("null-ls")

null_ls.setup({
  sources = { 
    -- prereq npm install -g @fsouza/prettierd
    null_ls.builtins.formatting.prettierd.with({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json" },
    }),
  }
})


local npairs = require("nvim-autopairs");
npairs.setup({
    -- check_ts = true,
    -- ts_config = {
    --     lua = {'string'},-- it will not add a pair on that treesitter node
    --     javascript = {'template_string'},
    --     java = false,-- don't check treesitter on java
    -- }
})

-- Treesitter TODO fix failling downloads
local ts = require('nvim-treesitter.configs')
ts.setup({
  highlight = { enable = true },
  indent = {
    enable = true,
  },
  autotag = {
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

require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
  },
}

-- require'treesitter-context'.setup()


-- Telescope 
require('telescope').setup {
  pickers = {
    -- show gitignore (issue with showing .git files)
    -- find_files = {
    --   hidden = true,
    -- }
  },
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
require("telescope").load_extension "file_browser"

-- vim.api.nvim_set_keymap('n', '<leader>fb', require 'telescope'.extensions.file_browser.file_browser, {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope file_browser path=%:p:h<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fi', ':Telescope find_files<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope live_grep<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>cm', ':Telescope commands<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>ch', ':Telescope command_history<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope current_buffer_fuzzy_find<cr>', {noremap = true, silent=true})
-- vim.api.nvim_set_keymap('n', '<leader>fr', ':Telescope registers<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fk', ':Telescope marks<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fo', ':Telescope oldfiles<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fr', ':Telescope resume<cr>', {noremap = true, silent=true})
-- lsp telescope
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope lsp_document_symbols<cr>', {noremap = true, silent=true})
-- vim.api.nvim_set_keymap('n', '<leader>ws', ':Telescope lsp_dynamic_workspace_symbols<cr>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fd', ':Telescope diagnostics<cr>', {noremap = true, silent=true})

require'marks'.setup {

}

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    -- ['<Tab>'] = cmp.mapping.confirm {
    --   -- behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },
    ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
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
  -- colorscheme = 'onedark',
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'relativepath', 'modified' } },
    right = { { 'percent' } }
  },
  inactive = {
    left = { { 'relativepath', 'modified' } }
  },
  component_function = { gitbranch = 'fugitive#head' },
}

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


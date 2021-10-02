call plug#begin()
Plug 'tpope/vim-surround'
" Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ggandor/lightspeed.nvim'
" Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go'

Plug 'lambdalisue/fern.vim'
Plug 'tpope/vim-repeat'
call plug#end()

set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set number
set relativenumber
set scrolloff=1

" Mappings
map <Space> <Leader>
nnoremap <leader>b :ls<CR>:b




colorscheme tokyonight

" Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"   
let g:go_auto_type_info = 1           

" Plug 'junegunn/fzf.vim'
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>fl       :Lines<CR>

" vim-go
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'

" lua require("lsp_config")

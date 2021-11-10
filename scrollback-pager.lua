vim.cmd [[packadd hop]]

vim.opt.number=true -- line numbers
vim.opt.relativenumber=true -- relative numbers
vim.opt.cursorline=true -- highlight current line
vim.opt.mouse='a' -- use mouse
vim.opt.clipboard='unnamedplus'
vim.opt.virtualedit='all'

require'hop'.setup()
vim.api.nvim_set_keymap('', '<Space>', '<Leader>', {noremap = false, silent=true})
vim.api.nvim_set_keymap('n', 's', ':HopWord<CR>', {noremap = false, silent=true})

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

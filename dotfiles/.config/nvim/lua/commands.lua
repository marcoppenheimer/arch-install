vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

vim.cmd [[
  augroup HideNetrw
    autocmd VimEnter * silent! au! FileExplorer *
    autocmd VimEnter * :silent exec "!kill -s WINCH $PPID"
    autocmd VimEnter * exec "cd %:p:h"
  augroup end
]]

vim.cmd [[
  autocmd FileType markdown setlocal spell
]]

vim.cmd [[
  command! Q :q
  command! W :w
  command! WQ :wq
]]

vim.cmd [[colorscheme onedark]]

vim.cmd [[ 
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

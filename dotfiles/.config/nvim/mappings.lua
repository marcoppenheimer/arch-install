-- run python
vim.api.nvim_set_keymap('n', '<C-`>', ':w | :! python %<CR>', { noremap=true, silent=true })

-- move multi lines
vim.api.nvim_set_keymap('', '<A-k>', ':m .-2<CR>==', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<A-j>', ':m .+1<CR>==', { noremap=true, silent=true })

-- remove Q
vim.api.nvim_set_keymap('', 'Q', '', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', 'q', '', { noremap=true, silent=true })

-- help window moving
vim.api.nvim_set_keymap('', '<C-j>', '<C-w><C-j>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<C-k>', '<C-w><C-k>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<C-l>', '<C-w><C-l>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('', '<C-h>', '<C-w><C-h>', { noremap=true, silent=true })

-- map space to leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ??
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- nnn bindings
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>NnnPicker %:p:h<CR>]], { noremap = true, silent = true })

-- telescope bindings
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep({hidden = true})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Space>', [[<cmd>lua require('telescope.builtin').git_status()<CR>]], { noremap = true, silent = true })

-- diffview bindings
vim.api.nvim_set_keymap('n', '<leader>gg', [[<cmd>DiffviewOpen<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gx', [[<cmd>DiffviewClose<CR>]], { noremap = true, silent = true })

-- diagnostic
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

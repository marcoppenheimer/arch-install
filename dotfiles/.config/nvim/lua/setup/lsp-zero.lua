local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.configure(
    "sumneko_lua",
    {
        settings = {
            Lua = {
               diagnostics = {
                   globals = { 'vim' }
                }
            }
        }
    }
)
lsp.configure(
    "pyright",
    {
        settings = {
            python = {
                analysis = {
                    extraPaths = {"./lib"}
                }
            }
        }
    }
)
lsp.setup()

local on_attach = function(_, bufnr)
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>so",
        [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>gr",
        [[<cmd> lua require('telescope.builtin').lsp_references()<CR>]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>gd",
        [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>D",
        [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>gi",
        [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],
        opts
    )
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local builtin = require("nnn").builtin
vim.cmd[[highlight NnnBorder guifg=#E5C07B]]
require("nnn").setup(
    {
        mappings = {
            {"<C-t>", builtin.open_in_tab},
            {"<C-s>", builtin.open_in_split},
            {"<C-v>", builtin.open_in_vsplit},
            {"<C-e>", builtin.open_in_preview},
            {"<C-y>", builtin.copy_to_clipboard},
            {"<C-w>", builtin.cd_to_path},
            {"<C-e>", builtin.populate_cmdline}
        },
        picker = {
            cmd = "tmux new-session -e BAT_THEME=OneHalfDark nnn -Pp -G -Q -e",
            style = {border = "rounded"}
        }
    }
)

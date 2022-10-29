require("telescope").setup {
    defaults = {
        file_ignore_patterns = {".git/*"},
        file_ignore_panel = {
            "venv",
            "__pycache__"
        }
    }
}
require("telescope").load_extension "fzf"


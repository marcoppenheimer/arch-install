local custom_onedark = require "lualine.themes.onedark"

custom_onedark.normal.a.bg = "#c678dd"
custom_onedark.visual.a.bg = "#e06c75"

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = custom_onedark,
        component_separators = "|",
        section_separators = ""
    },
    sections = {
        lualine_c = {{"filename", path = 2}}
    }
}

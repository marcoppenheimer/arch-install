-- Install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
vim.api.nvim_command("packadd packer.nvim")
function get_setup(name)
    return string.format('require("setup/%s")', name)
end

require("packer").startup(
    function(use)
        use("wbthomason/packer.nvim")
        use({"navarasu/onedark.nvim", config = get_setup("onedark")})
        use({"numToStr/Comment.nvim", config = get_setup("comment")})
        use({"luukvbaal/nnn.nvim", config = get_setup("nnn")})
        use({"ggandor/leap.nvim", config = get_setup("leap")})
        use(
            {
                "nvim-telescope/telescope.nvim",
                requires = {"nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "kyazdani42/nvim-web-devicons"},
                config = get_setup("telescope")
            }
        )
        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
        use({"nvim-treesitter/nvim-treesitter", config = get_setup("treesitter"), run = ":TSUpdate"})
        use "nvim-treesitter/nvim-treesitter-textobjects"
        use "tpope/vim-fugitive"
        use "tpope/vim-rhubarb"
        use {"sindrets/diffview.nvim", requires = {"nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons"}}
        use({"nvim-lualine/lualine.nvim", config = get_setup("lualine")})
        use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}, config = ("gitsigns")}
        use ({
            "VonHeikemen/lsp-zero.nvim",
            requires = {
                {"neovim/nvim-lspconfig"},
                {"williamboman/mason.nvim"},
                {"williamboman/mason-lspconfig.nvim"},
                -- Autocompletion
                {"hrsh7th/nvim-cmp"},
                {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-path"},
                {"saadparwaiz1/cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-nvim-lua"},
                -- Snippets
                {"L3MON4D3/LuaSnip"},
                {"rafamadriz/friendly-snippets"}
            }, config=get_setup("lsp-zero")})
    end
)

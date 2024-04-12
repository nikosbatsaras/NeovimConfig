return {
        "nvim-treesitter/nvim-treesitter",
        config = function()
                local treesitter = require("nvim-treesitter.configs")

                treesitter.setup({
                        highlight = {
                                enable = true,
                        },

                        indent = { enable = true },

                        ensure_installed = {
                                "json",
                                "yaml",
                                "markdown",
                                "markdown_inline",
                                "bash",
                                "lua",
                                "vim",
                                "dockerfile",
                                "gitignore",
                                "vimdoc",
                                "go",
                        },

                        auto_install = true,
                })
        end,
}

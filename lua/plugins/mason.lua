return {
        "williamboman/mason.nvim",
        opts = {
                ensure_installed = {
                        "gopls",
                        "golines",
                        "lua-language-server",
                },
        },
        dependencies = {
                "williamboman/mason-lspconfig.nvim",
        },
}

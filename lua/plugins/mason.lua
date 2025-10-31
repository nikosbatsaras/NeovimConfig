return {
        "williamboman/mason.nvim",
        opts = {
                ensure_installed = {
                        "gopls",
                        "lua-language-server",
                },
        },
        dependencies = {
                "williamboman/mason-lspconfig.nvim",
        },
}

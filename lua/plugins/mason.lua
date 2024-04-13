return {
        "williamboman/mason.nvim",
        opts = {
                ensure_installed = {
                        "gopls",
                },
        },
        dependencies = {
                "williamboman/mason-lspconfig.nvim",
        },
}

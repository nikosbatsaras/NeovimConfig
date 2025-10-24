return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
        config = function()
                -- setup must be called before loading
                vim.cmd.colorscheme "tokyonight-night"
        end,
}

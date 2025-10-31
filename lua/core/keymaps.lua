vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", "<cmd>close<CR>")

keymap.set("n", ">", "<cmd>tabn<CR>")
keymap.set("n", "<", "<cmd>tabp<CR>")
keymap.set("n", "<Right>", "<cmd>:tabmove +1<CR>")
keymap.set("n", "<Left>", "<cmd>:tabmove -1<CR>")

keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>")

keymap.set("n", "gD", vim.lsp.buf.declaration)
keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>")
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>")
keymap.set("n", "gl", "<cmd>Git blame<CR>")
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
keymap.set("n", "<leader>gh", "<cmd>Telescope git_stash<CR>")
keymap.set("n", "<leader>G", "<cmd>Neogit<CR>")
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>")
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "<leader>rs", ":LspRestart<CR>")

keymap.set("n", "<F6>", "<cmd>setlocal spell! spelllang=en<CR>")
keymap.set("n", "<F7>", "<cmd>setlocal spell! spelllang=el<CR>")

keymap.set("i", "<C-a>", "<C-g>u<Esc>[s1z=`]a<C-g>u")
keymap.set("n", "<C-a>", "i<C-g>u<Esc>[s1z=`]a<C-g>u<Esc>")

-- Source: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-config
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    if client then
      local params = vim.lsp.util.make_range_params(nil, client.offset_encoding or "utf-16")
      params.context = {only = {"source.organizeImports"}}
      -- buf_request_sync defaults to a 1000ms timeout. Depending on your
      -- machine and codebase, you may want longer. Add an additional
      -- argument after params if you find that you have to write the file
      -- twice for changes to be saved.
      -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
      for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
            vim.lsp.util.apply_workspace_edit(r.edit, enc)
          end
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

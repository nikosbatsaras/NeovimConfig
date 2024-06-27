vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", "<cmd>close<CR>")

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
keymap.set("n", ">", "<cmd>tabn<CR>")
keymap.set("n", "<", "<cmd>tabp<CR>")

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

keymap.set("n", "<leader>T", function()
        local testName = vim.fn.expand("<cword>")
        local currDir = vim.fn.expand("%:p:h")
        local cmd = 'cd ' .. currDir .. ' && go test -testify.m ' .. testName .. ' ' .. currDir
        local output = vim.fn.system(cmd)
        local lines = vim.fn.split(output, '\n')
        vim.cmd('new')
        for _, line in ipairs(lines) do
                vim.fn.append('$', line)
        end
        vim.opt_local.buftype = 'nofile'
        vim.opt_local.bufhidden = 'wipe'
        vim.opt_local.readonly = true
        vim.cmd('resize 10')
end)

vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go" },
        callback = function()
                local params = vim.lsp.util.make_range_params(nil, "utf-16")
                params.context = { only = { "source.organizeImports" } }
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                for _, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                                if r.edit then
                                        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                                else
                                        vim.lsp.buf.execute_command(r.command)
                                end
                        end
                end
        end,
})

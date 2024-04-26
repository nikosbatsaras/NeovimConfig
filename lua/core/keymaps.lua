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

vim.api.nvim_exec([[
" Run Golang test function
nnoremap <leader>t :call RunTest()<CR>

function! RunTest()
	let testName = expand("<cword>")
	let currDir = expand("%:p:h:.")
	let cmd = 'cd ' . currDir . ' && go test -testify.m ' . testName . ' ' . currDir
	let output = system(cmd)
	let lines = split(output, '\n')
	execute 'new'
	for line in lines
		call append('$', line)
	endfor
	setlocal buftype=nofile bufhidden=wipe nobuflisted
	setlocal readonly
	execute 'resize 10'
endfunction
]], false)

vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        callback = function()
                vim.lsp.buf.format { async = false }
        end
})

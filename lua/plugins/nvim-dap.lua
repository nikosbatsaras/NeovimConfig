return {
        "mfussenegger/nvim-dap",
        dependencies = {
                "rcarriga/nvim-dap-ui",
                "leoluz/nvim-dap-go",
                "nvim-neotest/nvim-nio",
        },
        config = function()
                local dap = require("dap")
                local dapui = require("dapui")
                local dapgo = require("dap-go")

                dapgo.setup()
                dapui.setup()

                vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
                vim.keymap.set('n', '<Leader>do', function() dap.step_over() end)
                vim.keymap.set('n', '<Leader>di', function() dap.step_into() end)
                vim.keymap.set('n', '<Leader>du', function() dap.step_out() end)
                vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
                vim.keymap.set('n', '<Leader>dl', function() dap.clear_breakpoints() end)

                vim.keymap.set('n', '<Leader>dt', function() dapgo.debug_test() end)

                dap.listeners.before.attach.dapui_config = function()
                        dapui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                        dapui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                        dapui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                        dapui.close()
                end

                dap.adapters.go_remote = {
                        type = 'server',
                        host = '127.0.0.1',
                        port = 40000,
                }

                table.insert(dap.configurations.go, {
                        type = 'go_remote',
                        request = 'attach',
                        name = 'Attach remote',
                        mode = 'remote',
                        substitutePath = { {
                                from = "${workspaceFolder}",
                                to = "/webapp/"
                        } },
                        connect = function()
                                local host = vim.fn.input('Host [127.0.0.1]: ')
                                host = host ~= '' and host or '127.0.0.1'
                                local port = tonumber(vim.fn.input('Port [40000]: ')) or 40000
                                return { host = host, port = port }
                        end,
                })
        end,
}

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      vim.keymap.set("n", "<Leader>dc", function()
        dap.continue()
      end, { desc = "Continue" })

      vim.keymap.set("n", "<Leader>dsl", function()
        dap.step_over()
      end, {desc = "Step Over"})

      vim.keymap.set("n", "<Leader>dsj", function()
        dap.step_into()
      end, {desc = "Step Into"})

      vim.keymap.set("n", "<Leader>dsk", function()
        dap.step_out()
      end, {desc = "Step Out"})

      vim.keymap.set("n", "<Leader>dBt", function()
        dap.toggle_breakpoint()
      end, {desc = "Breakpoint Toggle"})

      vim.keymap.set("n", "<Leader>dBs", function()
        dap.set_breakpoint()
      end, {desc = "Breakpoint Set"})

      vim.keymap.set("n", "<Leader>dL", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, {desc = "Set Breakpoint with Log Message"})

      vim.keymap.set("n", "<Leader>dr", function()
        dap.repl.open()
      end, {desc = "REPL Open"})

      vim.keymap.set("n", "<Leader>dl", function()
        dap.run_last()
      end, {desc = "Run Last"})

      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end, {desc = "Hover"})

      vim.keymap.set({ "n", "v" }, "<Leader>dP", function()
        require("dap.ui.widgets").preview()
      end, {desc = "Preview"})

      vim.keymap.set("n", "<Leader>dF", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end, {desc = "Frames"})

      vim.keymap.set("n", "<Leader>dS", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, {desc = "Scopes"})

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
    end,
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/cmp-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    depends = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
  },
}

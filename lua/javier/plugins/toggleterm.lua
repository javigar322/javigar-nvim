return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    -- craete a floating terminal
    local float_term = Terminal:new({
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!") -- start on insert mode
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<C-q>",
          "<cmd>close<CR>",
          { desc = "close terminal", noremap = true, silent = true }
        )
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,

      close_on_exit = false,
    })
    function _float_term_toggle()
      float_term:toggle()
    end

    vim.api.nvim_set_keymap(
      "n",
      "<leader>ft",
      "<cmd>lua _float_term_toggle()<CR>",
      { noremap = true, silent = true, desc = "toggle floating terminal" }
    )
    -- create the lazy git terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "n",
          "q",
          "<cmd>close<CR>",
          { desc = "close terminal", noremap = true, silent = true }
        )
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap(
      "n",
      "<leader>lg",
      "<cmd>lua _lazygit_toggle()<CR>",
      { desc = "open lazy git terminal", noremap = true, silent = true }
    )
  end,
}

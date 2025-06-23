-- Show absolute line numbers
vim.opt.number = true

-- Disable relative numbers if cursor jumps after editing
vim.opt.relativenumber = false

-- Optional: highlight the current line
vim.opt.cursorline = true

-- Optional: restore cursor to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- show virtual‐text errors as you type
vim.diagnostic.config({
  virtual_text     = true,
  signs            = true,
  update_in_insert = true,
})

-- pick & preview colorschemes
vim.keymap.set("n", "<leader>cs", function()
  require("telescope.builtin").colorscheme({
    enable_preview = true, -- live preview as you move
  })
end, { desc = "Choose colorscheme" })



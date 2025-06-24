-- UNDO / REDO
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo in Insert Mode" })

vim.keymap.set("n", "<C-S-z>", "<C-r>", { desc = "Redo" }) -- Ctrl+Shift+Z
vim.keymap.set("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo in Insert Mode" })

vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "Redo (VS Code Style)" })
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { desc = "Redo (Insert)" })

-- SAVE
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File in Insert Mode" })

-- NEW FILE
vim.keymap.set("n", "<C-n>", ":enew<CR>", { desc = "New File" })

-- CLOSE FILE / BUFFER
vim.keymap.set("n", "<C-w>", ":bd<CR>", { desc = "Close Buffer" })
vim.keymap.set("i", "<C-w>", "<Esc>:bd<CR>", { desc = "Close Buffer in Insert Mode" })

-- COMMENT TOGGLE (requires Comment.nvim)
-- Normal mode
vim.keymap.set("n", "<C-s-/>", "gcc", { remap = true, desc = "Toggle Comment" })
-- Insert mode
vim.keymap.set("i", "<C-s-/>", "<Esc>gccA", { remap = true, desc = "Toggle Comment in Insert Mode" })
-- Visual mode
vim.keymap.set("v", "<C-s-/>", "gc", { remap = true, desc = "Toggle Comment (Visual)" })

-- SELECT ALL (Ctrl+A)
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select All from Insert Mode" })

-- FIND / SEARCH (like Ctrl+F)
vim.keymap.set("n", "<C-f>", "/", { desc = "Search Forward" })
vim.keymap.set("i", "<C-f>", "<Esc>/", { desc = "Search from Insert Mode" })

-- TOGGLE TERMINAL like VS Code (Ctrl + `)
vim.keymap.set("n", "<C-`>", function()
  -- Toggle terminal (split or floating)
  local term_buf = vim.fn.bufnr("term://*")
  if vim.fn.bufexists(term_buf) == 1 then
    vim.cmd("bdelete! " .. term_buf) -- Close if already open
  else
    vim.cmd("split | terminal") -- Or use `vsplit` or a floating terminal plugin
  end
end, { desc = "Toggle Terminal" })

vim.keymap.set("t", "<C-`>", [[<C-\><C-n>:bd!<CR>]], { desc = "Close Terminal", noremap = true })


vim.keymap.set("n", "<leader>cs", function()
  require("telescope.builtin").colorscheme({
    enable_preview = true, -- live preview as you move
  })
end, { desc = "Choose colorscheme" })
local tc = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', tc.find_files, {})
vim.keymap.set('n', '<leader>fg', tc.live_grep, {})
vim.keymap.set('n', '<leader>fb', tc.buffers, {})

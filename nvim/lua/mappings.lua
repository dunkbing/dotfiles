-- >> Telescope bindings
-- find files
-- nnoremap <Leader>ff <cmd>lua require'telescope.builtin'.find_files{}<CR>
-- most recently used files
-- nnoremap <Leader>of <cmd>lua require'telescope.builtin'.oldfiles{}<CR>
-- find buffer
-- nnoremap <Leader>fb <cmd>lua require'telescope.builtin'.buffers{}<CR>
-- ripgrep like grep through dir
-- nnoremap <Leader>rg <cmd>lua require'telescope.builtin'.live_grep{}<CR>
-- pick color scheme
-- nnoremap <Leader>cs <cmd>lua require'telescope.builtin'.colorscheme{}<CR>

-- >> Lsp key bindings
-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
-- nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>

local wk = require('which-key')
local nvim_set_keymap = vim.api.nvim_set_keymap
local default_opt = { noremap = true, silent = true }

nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opt)
nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opt)
nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opt)
nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_opt)
-- nvim_set_keymap('n', '<CS-p>', '<cmd>Telescope command_palette<CR>', default_opt)

wk.register({
    f = {
        name = 'file', -- optional group name
        f = { '<cmd>Telescope find_files<cr>', 'Find File' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
        b = { '<cmd>Telescope buffers<cr>', 'Find buffer fiels' },
        B = { '<cmd>Telescope git_branches<cr>', 'Find git branches' },
    },
    c = {
        s = { '<cmd>Telescope colorscheme<cr>', 'Color scheme' },
        p = { '<cmd>Telescope command_palette<cr>', 'Command palette' }
    },
}, { prefix = "<leader>" })


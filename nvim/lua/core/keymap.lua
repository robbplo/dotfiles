-- Functional wrapper for mapping custom keybindings
local function mapfun(mode)
  return function(lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end
end

local nmap = mapfun('n')
local map = mapfun('')

local function cmd(command)
  return '<cmd>' .. command .. '<cr>'
end

-- Space as leader
vim.g.mapleader = " "

-- General
nmap('<leader>P', cmd('PackerSync'))
---- Copy to clipboard
map('<leader>y', '"+y')
---- Paste from clipboard
map('<leader>p', '"+P')
---- Copy current filename to clipboard
nmap('<leader>cf', cmd('let @+=@%'))

-- Panes
---- Resize
nmap('<S-Left>', cmd('vertical resize -1'))
nmap('<S-Right>', cmd('vertical resize +1'))
nmap('<S-Up>', cmd('resize -1'))
nmap('<S-Down>', cmd('resize +1'))

-- Barbar
---- Move to previous/next buffer
map('<A-h>', cmd('BufferPrevious'))
map('<A-l>', cmd('BufferNext'))
map('<A-Left>', cmd('BufferPrevious'))
map('<A-Right>', cmd('BufferNext'))
---- Goto buffer in position...
map('<A-1>', cmd('BufferGoto 1'))
map('<A-2>', cmd('BufferGoto 2'))
map('<A-3>', cmd('BufferGoto 3'))
map('<A-4>', cmd('BufferGoto 4'))
map('<A-5>', cmd('BufferGoto 5'))
map('<A-6>', cmd('BufferGoto 6'))
map('<A-7>', cmd('BufferGoto 7'))
map('<A-8>', cmd('BufferGoto 8'))
map('<A-9>', cmd('BufferGoto 9'))
map('<A-0>', cmd('BufferLast'))
---- Pin/unpin buffer
map('<A-p>', cmd('BufferPin'))
---- Close buffer
map('<A-c>', cmd('BufferClose'))
map('<A-C>', cmd('BufferCloseAllButCurrentOrPinned'))

-- Trouble
nmap('<leader>xx', cmd('Trouble diagnostics toggle'))
nmap('<leader>xd', cmd('Trouble diagnostics filter.buf=0 toggle'))
nmap('<leader>xq', cmd('Trouble quickfix toggle'))
nmap('<leader>xl', cmd('Trouble loclist toggle'))
nmap('<leader>xn', cmd('lua require("trouble").next({skip_groups = true, jump = true})'))
nmap('<leader>xp', cmd('lua require("trouble").previous({skip_groups = true, jump = true})'))

-- File explorer
nmap('<leader>e', cmd('Oil'))
nmap('<leader>E', cmd('Oil .'))

-- Telescope
nmap('<leader>T', cmd('Telescope'))
nmap('<leader>tt', cmd('Telescope resume'))
nmap('<leader>tp', cmd('Telescope find_files'))
nmap('<leader>tP', cmd('lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true})'))
nmap('<leader>tf', cmd('Telescope live_grep'))
nmap('<leader>tF', cmd('lua require("telescope.builtin").live_grep({ no_ignore = true})'))

-- Git
nmap('<leader>gn', cmd('Gitsigns next_hunk'))
nmap('<leader>gp', cmd('Gitsigns prev_hunk'))
nmap('<leader>gb', cmd('Gitsigns blame_line'))
nmap('<leader>gd', cmd('Gitsigns diffthis'))
nmap('<leader>gr', cmd('Gitsigns reset_hunk'))

---- Telescope mappings
nmap('<leader>gs', cmd('Telescope git_status'))
nmap('<leader>gB', cmd('Telescope git_branches'))

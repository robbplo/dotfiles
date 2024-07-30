vim.g.neovide_ = 0.8
vim.g.neovide_transparency = 0.8

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

if vim.g.neovide then
  vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', { noremap = true })
  vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', { noremap = true })
  vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
  vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', { noremap = true })
  vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })
end

-- Automatically start rpc server for Godot projects
local start_server = function()
  local server_path = "/tmp/godotnvim"
  -- Automatically start server for external editor
  for _key, value in pairs(vim.fn.serverlist()) do
    if value == server_path then
      return
    end
  end
  vim.fn.serverstart(server_path)
end

local project_file = vim.fn.getcwd() .. '/project.godot'
if vim.fn.filereadable(project_file) == 1 then
  start_server()
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
  -- This is where we attach the autoformatting for reasonable clients
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      error("lsp client is nil")
    end

    if client.name == 'gdscript' then
      start_server()
    end
  end
})

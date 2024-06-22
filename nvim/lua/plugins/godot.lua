-- Automatically start rpc server for Godot projects
local project_file = vim.fn.getcwd() .. '/project.godot'
if vim.fn.filereadable(project_file) == 1 then
  local server_path = "/tmp/godotnvim"
  if vim.fn.filereadable(server_path) == 1 then
    print("godot server already started")
    return
  end
  -- Automatically start server for external editor
  for _key, value in pairs(vim.fn.serverlist()) do
    if value == server_path then
      return
    end
  end
  vim.fn.serverstart(server_path)
end

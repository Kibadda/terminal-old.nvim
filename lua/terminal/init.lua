local M = {}

---@param user_config? TerminalConfig
function M.configure(user_config)
  require("terminal.config").set(user_config)
end

return M

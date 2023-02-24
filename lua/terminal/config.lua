local M = {}

function M.defaults()
  ---@class TerminalConfig
  local defaults = {
    log = nil,
    options = {
      filetype = "term",
      winbar = "",
      statuscolumn = "",
      statusline = "",
      relativenumber = false,
      number = false,
      signcolumn = "no",
      cursorline = false,
    },
    startinsert = true,
    autoclose = true,
  }
  return defaults
end

M.options = M.defaults()

function M.set(user_config)
  M.options = vim.tbl_deep_extend("force", M.defaults(), user_config or {})
end

return M

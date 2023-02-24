local M = {}

local usercmd = vim.api.nvim_create_user_command

function M.terminalopen()
  usercmd("TerminalOpen", function(opts)
    local config = require "terminal.config"

    local cmd
    if config.options.bang_opens == "vsplit" then
      cmd = opts.bang and "vsplit" or "split"
    else
      cmd = opts.bang and "split" or "vsplit"
    end
    vim.cmd(("%s | terminal %s"):format(cmd, opts.args))
  end, {
    nargs = "*",
    complete = "shellcmd",
    bang = true,
    desc = "Opens terminal in split. Use ! to split vertical",
  })
end

return M

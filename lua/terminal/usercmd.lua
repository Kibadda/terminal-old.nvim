local M = {}

local usercmds = {
  TerminalOpen = {
    fun = function(opts)
      local config = require "terminal.config"

      local cmd
      if config.options.bang_opens == "vsplit" then
        cmd = opts.bang and "vsplit" or "split"
      else
        cmd = opts.bang and "split" or "vsplit"
      end
      vim.cmd(("%s | terminal %s"):format(cmd, opts.args))
    end,
    opts = {
      nargs = "*",
      complete = "shellcmd",
      bang = true,
      desc = "Opens terminal in (v)split. Use ! to split in other direction.",
    },
  },
}

function M.register_usercmds()
  for name, args in pairs(usercmds) do
    vim.api.nvim_create_user_command(name, args.fun, args.opts)
  end
end

return M

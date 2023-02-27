if vim.g.loaded_Terminal == 1 then
  return
end

vim.g.loaded_Terminal = 1

require("terminal.autocmd").register_autocmds()
require("terminal.usercmd").register_usercmds()

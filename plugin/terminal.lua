if vim.g.loaded_Terminal == 1 then
  return
end

vim.g.loaded_Terminal = 1

local autocmd = require "terminal.autocmd"
autocmd.termopen()
autocmd.bufenter()

local usercmd = require "terminal.usercmd"
usercmd.terminalopen()

local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("TerminalAutoGroup", { clear = true })

function M.termopen()
  autocmd("TermOpen", {
    group = group,
    callback = function(opts)
      local config = require "terminal.config"

      if not config.options.hooks.termopen or config.options.hooks.termopen() then
        if config.options.options then
          for option, value in pairs(config.options.options) do
            vim.opt_local[option] = value
          end
        end

        if config.options.keymaps then
          for lhs, rhs in pairs(config.options.keymaps) do
            if rhs then
              vim.keymap.set("t", lhs, rhs, { buffer = opts.buf })
            end
          end
        end

        if config.options.startinsert then
          vim.cmd.startinsert()
        end

        if config.options.autoclose then
          local split = vim.split(opts.file, ":")
          if split[#split] == vim.opt.shell:get() then
            M.termclose(opts.buf)
          end
        end
      end
    end,
  })
end

function M.termclose(buffer)
  autocmd("TermClose", {
    group = group,
    buffer = buffer,
    once = true,
    callback = function()
      local config = require "terminal.config"

      if vim.bo.filetype == (config.options.options.filetype or "term") then
        if not config.options.hooks.termopen or config.options.hooks.termopen() then
          vim.cmd.bd { bang = true }
        end
      end
    end,
  })
end

function M.bufenter()
  autocmd("BufEnter", {
    group = group,
    pattern = "term://*",
    callback = function()
      local config = require "terminal.config"

      if not config.options.hooks.bufenter or config.options.hooks.bufenter() then
        if config.options.startinsert then
          vim.cmd.startinsert()
        end
      end
    end,
  })
end

return M

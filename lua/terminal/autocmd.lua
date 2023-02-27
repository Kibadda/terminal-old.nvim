local M = {}

local autocmds = {
  TermOpen = {
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
      end
    end,
  },
  TermClose = {
    callback = function(opts)
      local config = require "terminal.config"

      if vim.bo[opts.buf].filetype == (config.options.options.filetype or "term") then
        if not config.options.hooks.termopen or config.options.hooks.termopen() then
          if config.options.autoclose then
            local split = vim.split(opts.file, ":")
            if split[#split] == vim.opt.shell:get() then
              vim.cmd.bd { bang = true }
            end
          end
        end
      end
    end,
  },
  BufEnter = {
    pattern = "term://*",
    callback = function()
      local config = require "terminal.config"

      if not config.options.hooks.bufenter or config.options.hooks.bufenter() then
        if config.options.startinsert then
          vim.cmd.startinsert()
        end
      end
    end,
  },
}

function M.register_autocmds()
  local group = vim.api.nvim_create_augroup("TerminalAutoGroup", { clear = true })

  for event, opts in pairs(autocmds) do
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
  end
end

return M

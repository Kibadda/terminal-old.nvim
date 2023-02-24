if vim.g.loaded_Terminal == 1 then
  return
end

vim.g.loaded_Terminal = 1

local group = vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function(opts)
    local config = require "terminal.config"
    for option, value in pairs(config.options.options) do
      vim.opt_local[option] = value
    end

    if config.options.startinsert then
      vim.cmd.startinsert()
    end

    if config.options.autoclose then
      local split = vim.split(opts.file, ":")
      if split[#split] == vim.opt.shell:get() then
        vim.api.nvim_create_autocmd("TermClose", {
          group = group,
          buffer = opts.buf,
          once = true,
          callback = function()
            if vim.bo.filetype ~= "TelescopePrompt" then
              vim.cmd.bd { bang = true }
            end
          end,
        })
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "term://*",
  callback = function()
    local config = require "terminal.config"
    if config.options.startinsert then
      vim.cmd.startinsert()
    end
  end,
})

vim.api.nvim_create_user_command("T", function(opts)
  vim.cmd(("%s | terminal %s"):format(opts.bang and "vsplit" or "split", opts.args))
end, {
  nargs = "*",
  complete = "shellcmd",
  bang = true,
  desc = "Opens terminal in split. Use ! to split vertical",
})

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

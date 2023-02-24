local M = {}

function M.defaults()
  ---@class TerminalConfig
  local defaults = {
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
    keymaps = {
      ["<C-h>"] = "<C-\\><C-n><C-w>h",
      ["<C-j>"] = "<C-\\><C-n><C-w>j",
      ["<C-k>"] = "<C-\\><C-n><C-w>k",
      ["<C-l>"] = "<C-\\><C-n><C-w>l",
    },
    hooks = {
      ---@type fun(): boolean
      termopen = function()
        return true
      end,
      ---@type fun(): boolean
      termclose = function()
        return true
      end,
      ---@type fun(): boolean
      bufenter = function()
        return true
      end,
    },
    startinsert = true,
    autoclose = true,
    ---@type "split"|"vsplit"
    bang_opens = "split",
  }
  return defaults
end

M.options = M.defaults()

function M.set(user_config)
  M.options = vim.tbl_deep_extend("force", M.defaults(), user_config or {})
end

return M

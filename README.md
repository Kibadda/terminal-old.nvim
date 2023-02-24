# terminal

## :wrench: Installation
Install with your favorite package manager

e.g. [Lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
return {
  "Kibadda/laravel-docs.nvim"
}
```

## :bulb: Configuration
```lua
  local defaults = {
    -- these will be set via vim.opt_local
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
    -- if you want to disable the default ones
    -- just add ["<C-h>"] = false
    keymaps = {
      ["<C-h>"] = "<C-\\><C-n><C-w>h",
      ["<C-j>"] = "<C-\\><C-n><C-w>j",
      ["<C-k>"] = "<C-\\><C-n><C-w>k",
      ["<C-l>"] = "<C-\\><C-n><C-w>l",
    },
    -- if these hooks return false
    -- the default behavior will be overwritten
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
```

## :mag: Usage
Either run `:TerminalOpen` or map it to a key, e.g.:
```lua
vim.keymap.set("n", "<Leader>to", "<Cmd>TerminalOpen<CR>", {
  desc = "[T]erminal [O]pen"
})
```

# License
MIT License

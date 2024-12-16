vim.o.number = true -- Enable line numbers
vim.o.relativenumber = true -- Make line numbers relative
vim.o.tabstop = 2 -- Number of spaces a tab represents
vim.o.shidtwidth = 2 -- Number of spaces for each tab indentation
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smartindent = true -- Use smart indents =)
vim.o.copyindent = true -- Copy indent with code
vim.o.wrap = false -- Disable long lines wrap
vim.o.termguicolors = true -- Make terminal vim colors look like GVim

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  },
  checker = { enabled = true },
})

require('catppuccin').setup({
  flavour = 'frappe'
})

vim.cmd.colorscheme "catppuccin"


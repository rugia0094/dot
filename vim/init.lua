-- -------------------- Bootstrap lazy.nvim --------------------

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

-- -------------------- mapLeader and maplocalleader --------------------

-- TODO

-- -------------------- vim options --------------------

vim.opt.laststatus = 0

vim.opt.updatetime = 50

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.scrolloff = 10 

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"

vim.opt.number = true 
vim.opt.relativenumber = true 

vim.opt.tabstop = 2 
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true 

vim.opt.smartindent = true 
vim.opt.copyindent = true 

vim.opt.wrap = false 

vim.opt.termguicolors = true 

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- TODO show trailing spaces and tabs

-- -------------------- Setup lazy.nvim --------------------

require("lazy").setup({
  spec = {
    -- Rose pine colorscheme
    { "rose-pine/neovim", name = "rose-pine" },

    -- LSP

    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        "neovim/nvim-lspconfig",

        config = function()
          require('mason').setup()

          require('mason-lspconfig').setup {
            ensure_installed = { 'ts_ls', 'volar' },
            automatic_installation = true,
          }

          require'lspconfig'.ts_ls.setup{
            init_options = {
              plugins = {
                name = "@vue/typescript-plugin",
                location = "/home/anton/.nvm/versions/node/v22.11.0/lib/node_modules/@vue/typescript-plugin",
                languages = { 'vue' },
              },
            },

            filetypes = { 'javascript', 'typescript', 'vue', 'javascriptreact', 'typescriptreact' },
          }

          require'lspconfig'.volar.setup{}
        end,
    },

    -- Treesitter for better syntax highlighting and more
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
          -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html" },
          ensure_installed = "all",
          sync_install = true,
          auto_instal = false,
          highlight = {
            enable = true,
            disable = function (lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
          },
          indent = { enable = true },
        })
      end
    },
  },

  install = { missing = true, colorscheme = { "rose-pine" } },

  checker = { enabled = true },
})

-- -------------------- Setup colorscheme -------------------- 

require("rose-pine").setup({
  variant = "moon",
  dark_variant = "moon",
  dim_inactive_windows = true,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true,
    migrations = true,
  },

  styles = {
    bold = false,
    italic = false,
    transparency = true,
  },
})

vim.cmd.colorscheme('rose-pine')


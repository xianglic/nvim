require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'vim', 'json', "python", "cpp" }, -- add your languages
  auto_install = true,
  highlight = { enable = true },
})


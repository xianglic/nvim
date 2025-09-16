local vim = vim
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('rebelot/kanagawa.nvim')
Plug('kyazdani42/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')
Plug('romgrk/barbar.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-treesitter/nvim-treesitter')

Plug('neovim/nvim-lspconfig')      
Plug('hrsh7th/nvim-cmp')           
Plug('hrsh7th/cmp-nvim-lsp')       
Plug('hrsh7th/cmp-buffer')        
Plug('hrsh7th/cmp-path')         
Plug('L3MON4D3/LuaSnip')        
Plug('saadparwaiz1/cmp_luasnip') 

vim.call('plug#end')

home=os.getenv("HOME")
package.path = home .. "/.config/nvim/?.lua;" .. package.path
require"common"
require"vimtree"
require"barbar"
require"lua_line"
require"treesitter"
require"lsp"
require"theme"
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })



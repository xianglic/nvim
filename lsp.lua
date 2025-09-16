-- Better completion behavior
vim.o.completeopt = 'menu,menuone,noselect'

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'luasnip' },
  },
})

-- LSP keymaps per buffer
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end
  map('n', 'K', vim.lsp.buf.hover)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gr', vim.lsp.buf.references)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', '<leader>rn', vim.lsp.buf.rename)
  map('n', '<leader>ca', vim.lsp.buf.code_action)
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', ']d', vim.diagnostic.goto_next)
  map('n', 'gl', vim.diagnostic.open_float)
end

-- Capabilities so LSP knows you support completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Python LSP: pyright
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Optional: Ruff for linting (requires ruff-lsp installed)
-- lspconfig.ruff_lsp.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })


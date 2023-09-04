return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- [[ LSP Support ]]
    {'neovim/nvim-lspconfig'},
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'},

    -- [[ Autocompletion ]]
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        {
          "windwp/nvim-autopairs",
          opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
          },
          config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
          end,
        },
      }
    },
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
  },
  config = function()
    local lsp = require('lsp-zero').preset({
      manage_nvim_cmp = {
        set_sources = 'recommended'
      }
    })

    lsp.ensure_installed({
      'bashls',
      'clangd',
      'cssls',
      'solargraph',
    })

    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Insert }
    local cmp_mappings = lsp.defaults.cmp_mappings({
      ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
      ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Esc>'] = cmp.mapping.abort(),
    })

    lsp.set_preferences({
      sign_icons = {}
    })

    lsp.setup_nvim_cmp({
      mapping = cmp_mappings,
    })

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', 'vca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'vrr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'vrn', vim.lsp.buf.rename, opts)
      vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
    end)

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
  end
}

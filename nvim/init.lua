require("base")
require("keymaps")

vim.opt.clipboard = "unnamedplus"

vim.cmd.packadd 'vim-jetpack'
jetpack = require('jetpack')

require('jetpack.packer').startup(function(use)
  use 'tani/vim-jetpack'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "onsails/lspkind-nvim"

  use "hrsh7th/vim-vsnip"

  use 'lambdalisue/fern.vim'
  use {'junegunn/fzf', ['do'] = './install --bin' }
  use { 'ibhagwan/fzf-lua', requires = { 'nvim-tree/nvim-web-devicons' } }

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'hashivim/vim-terraform'
  use 'yaegassy/coc-volar'

  -- use 'github/copilot.vim'
  
  use 'windwp/nvim-ts-autotag'
  use 'nvim-treesitter/nvim-treesitter'

  use {
    'yetone/avante.nvim',
    branch = 'main',
    run = 'make',
    config = function()
      require('avante').setup({
        provider = 'copilot',
        auto_suggestion_provider = 'copilot'
      })
    end
  }

  -- Require plugins for avante.nvim
  use 'stevearc/dressing.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'

  -- Optional plugins for avante.nvim
  use 'nvim-tree/nvim-web-devicons'
  use 'HakonHarnes/img-clip.nvim'
  use {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",  -- ★ ここでTABを割り当て
          }
        }
      })
    end,
  }
end)

require('mason').setup()


require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- Function executed when the LSP server startup
    on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.format(nil, 1000)'
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  print(server)
  require('lspconfig')[server].setup(opt)
end })


local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },

  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'path'},
    {name = 'buffer'},
  }),
  
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
}

require('nvim-treesitter.configs').setup {
  autotag = {
    enable = true,
  }
}
require('nvim-ts-autotag').setup()

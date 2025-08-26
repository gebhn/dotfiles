vim.pack.add {
    'https://github.com/rktjmp/lush.nvim',
    'https://github.com/zenbones-theme/zenbones.nvim',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/whoissethdaniel/mason-tool-installer.nvim',
    'https://github.com/echasnovski/mini.nvim',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/saghen/blink.cmp',
}

for _, cfg in ipairs {
    'color',
    'mason',
    'mini',
    'conform',
    'treesitter',
    'blink',
} do
    require('plugins.' .. cfg)
end

for _, cfg in ipairs {
    'color',
    'mason',
    'nvim-conform',
    'nvim-cmp',
    'nvim-lspconfig',
    'nvim-treesitter',
    'mini',
} do
    require('plugins.' .. cfg)
end

for _, cfg in ipairs {
    'color',
    'mason',
    'mini',
    'nvim-conform',
    'nvim-cmp',
    'nvim-treesitter',
} do
    require('plugins.' .. cfg)
end

for _, cfg in ipairs {
    'blink-cmp',
    'color',
    'mason',
    'mini',
    'nvim-conform',
    'nvim-treesitter',
} do
    require('plugins.' .. cfg)
end

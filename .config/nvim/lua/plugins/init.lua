for _, cfg in ipairs {
    'color',
    'mason',
    'mini',
    'blink',
    'conform',
    'treesitter',
} do
    require('plugins.' .. cfg)
end

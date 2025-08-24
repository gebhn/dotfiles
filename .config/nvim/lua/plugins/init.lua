for _, cfg in ipairs {
    'dap',
    'color',
    'mason',
    'mini',
    'blink',
    'conform',
    'treesitter',
} do
    require('plugins.' .. cfg)
end

---@diagnostic disable: undefined-field

local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.uv.fs_stat(mini_path) then
    vim.cmd 'echo "Installing `mini.nvim`" | redraw'
    local cmd = {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim',
        mini_path,
    }
    vim.fn.system(cmd)
    vim.cmd 'packadd mini.nvim | helptags ALL'
    vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup {
    path = {
        package = path_package,
    },
}

local configs = {
    'color',
    'mason',
    'nvim-cmp',
    'nvim-conform',
    'nvim-lspconfig',
    'nvim-treesitter',
    'mini-ai',
    'mini-comment',
    'mini-extra',
    'mini-pairs',
    'mini-pick',
    'mini-surround',
}

for _, cfg in ipairs(configs) do
    require('plugins.' .. cfg)
end

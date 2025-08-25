local colors = {
    ['n'] = '%#PmenuThumb#',
    ['i'] = '%#DiffChange#',
    ['ic'] = '%#DiffChange#',
    ['v'] = '%#DiffAdd#',
    ['V'] = '%#DiffAdd#',
    [''] = '%#DiffAdd#',
    ['R'] = '%#DiffDelete#',
    ['c'] = '%#DiffDelete#',
    ['t'] = '%#DiffDelete#',
    default = '%#StatusLineAccent#',
}

local diagnostics_info = {
    errors = { severity = 'Error', symbol = 'E ' },
    warnings = { severity = 'Warn', symbol = 'W ' },
    info = { severity = 'Info', symbol = 'I ' },
    hints = { severity = 'Hint', symbol = 'H ' },
}

local get_filepath = function()
    local fpath = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.:h')
    return (fpath == '' or fpath == '.') and ' ' or string.format(' %%<%s/', fpath)
end

local get_filename = function()
    local fname = vim.fn.expand '%:t'
    return fname == '' and '' or fname .. ' '
end

local format_diagnostics = function(_, value)
    local count = vim.tbl_count(vim.diagnostic.get(0, { severity = value.severity }))
    if count ~= 0 then
        return string.format(' %%#Diagnostic%s#%s%d', value.severity, value.symbol, count)
    else
        return ''
    end
end

local get_lsp_diagnostics = function()
    local diagnostics = vim.iter(diagnostics_info)
        :map(format_diagnostics)
        :fold('', function(acc, cv) return acc .. cv end)
    return diagnostics .. '%#Normal#'
end

Statusline = {
    active = function()
        local current_mode = vim.api.nvim_get_mode().mode
        local mode_color = colors[current_mode] or colors.default
        local mode_name = string.format(' %s ', current_mode or ''):lower()
        local filetype = string.format(' %s ', vim.bo.filetype):lower()

        return '%#Statusline#'
            .. mode_color
            .. mode_name
            .. '%#Normal#'
            .. get_filepath()
            .. get_filename()
            .. '%#Normal#'
            .. get_lsp_diagnostics()
            .. '%=%#StatusLineExtra#'
            .. filetype
    end,
    inactive = function() return '%#Statusline#' .. ' %F' end,
}

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    pattern = { '*' },
    callback = function() vim.wo.statusline = '%!v:lua.Statusline.active()' end,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
    pattern = { '*' },
    callback = function() vim.wo.statusline = '%!v:lua.Statusline.inactive()' end,
})

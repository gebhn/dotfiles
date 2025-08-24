vim.pack.add {
    'https://github.com/mfussenegger/nvim-dap',
}

local dap = require 'dap'

dap.adapters.delve = function(callback, config)
    if config.mode == 'remote' and config.request == 'attach' then
        callback {
            type = 'server',
            host = config.host or '127.0.0.1',
            port = config.port or '38697',
        }
    else
        callback {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'dlv',
                args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
                detached = true,
            },
        }
    end
end

dap.configurations.go = {
    {
        type = 'delve',
        name = 'debug',
        request = 'launch',
        program = '${file}',
    },
    {
        type = 'delve',
        name = 'debug test',
        request = 'launch',
        mode = 'test',
        program = '${file}',
    },
}

local function eval_expression(expr)
    local mode = vim.api.nvim_get_mode()
    if mode.mode == 'v' then
        local start = vim.fn.getpos 'v'
        local end_ = vim.fn.getpos '.'

        local start_row = start[2]
        local start_col = start[3]

        local end_row = end_[2]
        local end_col = end_[3]

        if start_row == end_row and end_col < start_col then
            end_col, start_col = start_col, end_col
        elseif end_row < start_row then
            start_row, end_row = end_row, start_row
            start_col, end_col = end_col, start_col
        end

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'n', false)

        local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
        return table.concat(lines, '\n')
    end
    expr = expr or '<cexpr>'
    if type(expr) == 'function' then
        return expr()
    else
        return vim.fn.expand(expr)
    end
end

local function better_hover(expr, _)
    local value = eval_expression(expr)

    local bufnr, winid = vim.lsp.util.open_floating_preview({}, 'dap-float', {
        focusable = true,
        close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
        focus_id = 'dappp',
        focus = true,
        width = 100,
        height = 5,
    })

    local buffer_lines = vim.api.nvim_buf_get_lines(bufnr, 1, 999, false)
    if #buffer_lines ~= 0 then return end

    vim.bo[bufnr].bufhidden = 'wipe'
    vim.bo[bufnr].filetype = 'dap-float'
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].buftype = 'nofile'
    vim.api.nvim_buf_set_name(bufnr, 'dap-hover-' .. tostring(bufnr) .. ': ' .. value)

    vim.wo[winid].scrolloff = 0

    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<CR>',
        "<Cmd>lua require('dap.ui').trigger_actions({ mode = 'first' })<CR>",
        {}
    )
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'a', "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'o', "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<2-LeftMouse>', "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})

    local view = require('dap.ui.widgets')
        .builder(require('dap.ui.widgets').expression)
        .new_buf(function() return bufnr end)
        .new_win(require('dap.ui.widgets').with_resize(function() return winid end))
        .build()
    view.open(value)
    return view
end

---@diagnostic disable: undefined-field
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)

vim.keymap.set('n', '<leader>ds', dap.continue)
vim.keymap.set('n', '<leader>dr', dap.restart)

vim.keymap.set({ 'n', 'v' }, '<leader>dh', better_hover)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', function() require('dap.ui.widgets').preview() end)

vim.keymap.set('n', '<leader>si', dap.step_into)
vim.keymap.set('n', '<leader>so', dap.step_over)
vim.keymap.set('n', '<leader>sO', dap.step_out)
vim.keymap.set('n', '<leader>sb', dap.step_back)

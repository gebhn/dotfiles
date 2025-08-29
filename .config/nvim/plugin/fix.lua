vim.api.nvim_create_user_command('Fix', function(_)
	local diagnostics = vim.diagnostic.get()

	if #diagnostics == 0 then
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.cmd 'cclose'
			end
		end
		return
	end

	local items = {}
	for _, diag in ipairs(diagnostics) do
		table.insert(items, {
			filename = vim.api.nvim_buf_get_name(diag.bufnr or 0),
			lnum = diag.lnum + 1,
			col = diag.col + 1,
			text = diag.message,
		})
	end

	vim.fn.setqflist({}, 'r', { items = items })
	vim.cmd 'copen'
end, {})

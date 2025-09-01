local function qflist_diagnostics()
	local diagnostics = vim.diagnostic.get()

	if #diagnostics == 0 then
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.cmd.cclose()
			end
		end
		return
	end

	vim.diagnostic.setqflist()
	vim.cmd.copen()
end


vim.api.nvim_create_user_command('Fix', qflist_diagnostics, {})

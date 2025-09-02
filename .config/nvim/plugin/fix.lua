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

	vim.diagnostic.setqflist {
		format = function(diag)
			if #diag.message > 70 then
				return diag.message:sub(1, 70 - 3) .. '...'
			end
			return diag.message
		end
	}

	vim.cmd.copen()
end


vim.api.nvim_create_user_command('Fix', qflist_diagnostics, {})

local grep = 'git grep -n '
local files = 'git ls-files -c -o --exclude-standard'

local git_grep = function(cmdarg, _)
	if #cmdarg == 0 then return {} end

	local base = vim.split(vim.trim(io.popen(grep .. cmdarg):read('*a')), '\n')
	local found = {}

	for _, line in ipairs(base) do
		local fmt = line:gsub(':(%d+):%d+:', ':%1:')
		table.insert(found, fmt)
	end

	return found
end


local git_files = function(cmdarg, _, _)
	if #cmdarg == 0 then return {} end

	local base = vim.split(vim.trim(io.popen(files):read('*a')), '\n')
	local found = {}

	for _, file in ipairs(base) do
		if file:match(cmdarg) then
			table.insert(found, file)
		end
	end

	return found
end

local fix_diag = function()
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

local async_make = _G.async(function(opts)
	if vim.o.makeprg == '' then
		return
	end

	local args = table.concat(opts.fargs, ' ')
	local cmd = vim.o.makeprg:gsub('%$%*', args)

	local result = try_await(asystem(vim.fn.split(cmd)))

	if result.success then
		vim.fn.setqflist({}, ' ', {
			lines = vim.split(result.value.stdout or '', '\n'),
		})

		if result.value.stdout and result.value.stdout ~= '' then
			vim.cmd.copen()
		end
	else
		local err = result.error
		vim.fn.setqflist({}, ' ', {
			lines = vim.split(err.stderr or err.message or 'Unknown error', '\n'),
		})
		vim.cmd.copen()
	end
end)

local grep_command = function(opts)
	local file, lnum = opts.args:match '([^:]+):(%d+):'

	vim.cmd.edit { args = { file } }
	vim.fn.cursor(lnum, 1)
end

local files_command = function(opts)
	if vim.tbl_count(opts.fargs) > 0 then
		for _, arg in ipairs(opts.fargs) do
			vim.cmd.edit { args = { arg } }
		end
	end
end

vim.api.nvim_create_user_command('Make', async_make, {
	nargs = '*',
})
vim.api.nvim_create_user_command('Fix', fix_diag, {
	nargs = '*',
})
vim.api.nvim_create_user_command('Grep', grep_command, {
	complete = git_grep,
	nargs = '*',
})
vim.api.nvim_create_user_command('Files', files_command, {
	complete = git_files,
	nargs = '*',
})

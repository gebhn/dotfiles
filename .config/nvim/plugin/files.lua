local cmd = 'git ls-files -c -o --exclude-standard'

local git_files = function(cmdarg, _, _)
	if #cmdarg == 0 then return {} end

	local base = vim.split(vim.trim(io.popen(cmd):read('*a')), '\n')
	local found = {}

	for _, file in ipairs(base) do
		if file:match(cmdarg) then
			table.insert(found, file)
		end
	end

	return found
end

local command = function(opts)
	if vim.tbl_count(opts.fargs) > 0 then
		for _, arg in ipairs(opts.fargs) do
			vim.cmd.edit { args = { arg } }
		end
	end
end

vim.api.nvim_create_user_command('Files', command, {
	complete = git_files,
	nargs = '*',
})

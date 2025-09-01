local cmd = 'git grep -n '

local git_grep = function(cmdarg, _)
	if #cmdarg == 0 then return {} end

	local base = vim.split(vim.trim(io.popen(cmd .. cmdarg):read('*a')), '\n')
	local found = {}

	for _, line in ipairs(base) do
		local fmt = line:gsub(':(%d+):%d+:', ':%1:')
		table.insert(found, fmt)
	end

	return found
end

local command = function(opts)
	local file, lnum = opts.args:match '([^:]+):(%d+):'

	vim.cmd.edit { args = { file } }
	vim.fn.cursor(lnum, 1)
end

vim.api.nvim_create_user_command('Grep', command, {
	complete = git_grep,
	nargs = '*',
})

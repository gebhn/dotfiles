local cmd = 'rg --vimgrep --color=never --hidden --glob="!.git" '

_G.RgGrep = function(cmdarg, _)
	if #cmdarg == 0 then
		return {}
	end

	local res = vim.fn.systemlist(cmd .. vim.fn.shellescape(cmdarg))

	for i, line in ipairs(res) do
		res[i] = line:gsub(':(%d+):%d+:', ':%1:')
	end

	return res
end

vim.o.completefunc = 'v:lua.RgGrep'

vim.api.nvim_create_user_command('Grep', function(opts)
	local item = opts.args
	local filename, lnum = item:match '([^:]+):(%d+):'
	if filename and lnum then
		vim.cmd('edit ' .. filename)
		vim.fn.cursor(lnum, 1)
	end
end, { nargs = '*', complete = 'customlist,v:lua.RgGrep' })

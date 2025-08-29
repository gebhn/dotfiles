local cmd = 'rg --files --hidden --color=never --glob="!.git"'

_G.RgFindFiles = function(cmdarg, _)
	local fnames = vim.fn.systemlist(cmd)
	if #cmdarg == 0 then
		return fnames
	else
		return vim.fn.matchfuzzy(fnames, cmdarg)
	end
end

vim.o.findfunc = 'v:lua.RgFindFiles'

All = All or vim.fn.systemlist('rg --files --hidden --no-ignore --color=never --glob="!.git"')
Current = All

RgFindFiles = function(arglead, _)
	local base = Current or All or {}
	if #arglead == 0 then
		return base
	else
		return vim.fn.matchfuzzy(base, arglead)
	end
end

vim.o.findfunc = 'v:lua.RgFindFiles'

Refine = function()
	if vim.fn.getcmdtype() ~= ':' then
		return ''
	end

	local line = vim.fn.getcmdline()
	local cmdname, arg = line:match '^%s*(%S+)%s*(.*)$'
	if cmdname ~= 'find' then
		return ''
	end

	if #arg > 0 then
		local base = Current or All
		local narrowed = vim.fn.matchfuzzy(base, arg)
		if #narrowed > 0 then
			Current = narrowed
		end
	end

	vim.fn.setcmdline 'find '

	return vim.fn.nr2char(vim.o.wildchar)
end

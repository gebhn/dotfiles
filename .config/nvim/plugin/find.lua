_G.All = _G.All or vim.fn.systemlist('rg --files --hidden --no-ignore --color=never --glob="!.git"')
_G.Current = _G.All

RgFindFiles = function(arglead, _)
	local base = _G.Current or _G.All or {}
	if #arglead == 0 then
		return base
	else
		return vim.fn.matchfuzzy(base, arglead)
	end
end

vim.o.findfunc = 'v:lua.RgFindFiles'

_G.Refine = function()
	if vim.fn.getcmdtype() ~= ':' then
		return ''
	end

	local line = vim.fn.getcmdline()
	local cmdname, arg = line:match '^%s*(%S+)%s*(.*)$'
	if cmdname ~= 'find' then
		return ''
	end

	if #arg > 0 then
		local base = _G.Current or _G.All
		local narrowed = vim.fn.matchfuzzy(base, arg)
		if #narrowed > 0 then
			_G.Current = narrowed
		end
	end

	vim.fn.setcmdline 'find '

	return vim.fn.nr2char(vim.o.wildchar)
end

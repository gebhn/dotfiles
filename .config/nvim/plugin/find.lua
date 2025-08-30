local cmd = 'rg --files --hidden --no-ignore --color=never --glob="!.git"'

_G.all_fnames = _G.all_fnames or vim.fn.systemlist(cmd)
_G.current_fnames = _G.all_fnames

_G.RgFindFiles = function(arglead, _)
	local base = _G.current_fnames or _G.all_fnames or {}
	if #arglead == 0 then
		return base
	else
		return vim.fn.matchfuzzy(base, arglead)
	end
end

vim.o.findfunc = 'v:lua.RgFindFiles'

local refine = function()
	if vim.fn.getcmdtype() ~= ':' then
		return ''
	end

	local line = vim.fn.getcmdline()
	local cmdname, arg = line:match '^%s*(%S+)%s*(.*)$'
	if cmdname ~= 'find' then
		return ''
	end

	if #arg > 0 then
		local base = _G.current_fnames or _G.all_fnames
		local narrowed = vim.fn.matchfuzzy(base, arg)
		if #narrowed > 0 then
			_G.current_fnames = narrowed
		end
	end

	vim.fn.setcmdline 'find '

	return vim.fn.nr2char(vim.o.wildchar)
end

vim.keymap.set('c', '<C-f>', refine, { expr = true })

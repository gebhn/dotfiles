local cache, cached = {}, true

local refresh = function()
	if not cached then
		return
	end

	cached = false
	cache = {}

	cache = vim.fs.find(function(_, path)
		if path:match('%.git') then
			return false
		end
		return true
	end, {
		limit = math.huge,
		type = 'file',
		path = vim.fn.getcwd(),
	})

	vim.api.nvim_create_autocmd('CmdlineLeave', {
		once = true,
		callback = function()
			cached = true
		end,
	})
end

function _G.Find(cmdarg, _)
	if #cmdarg == 0 then
		refresh()
		return cache
	else
		return vim.fn.matchfuzzy(cache, cmdarg, { matchseq = 1, limit = 100 })
	end
end

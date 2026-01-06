local cache, cached = {}, true

function _G.Find(cmdarg, _)
	if #cmdarg == 0 then
		if not cached then
			return
		end

		cached = false
		cache = {}

		local names = function(_, path)
			if path:match('%.git') then
				return false
			end
			return true
		end

		local opts = {
			limit = math.huge,
			type = 'file',
			path = vim.fn.getcwd(),
		}

		cache = vim.fs.find(names, opts)

		vim.api.nvim_create_autocmd('CmdlineLeave', {
			once = true,
			callback = function()
				cached = true
			end,
		})

		return cache
	else
		return vim.fn.matchfuzzy(cache, cmdarg, { matchseq = 1, limit = 100 })
	end
end

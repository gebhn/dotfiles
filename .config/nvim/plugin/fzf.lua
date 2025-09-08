-- https://elanmed.dev/blog/native-fzf-in-neovim


local colors = table.concat({
	"--color=",
	"bg:-1,bg+:-1,",
	"fg:white,fg:regular,fg+:white,fg+:regular,",
	"hl:white,hl:bold,hl+:white,hl+:reverse,",
	"prompt:-1,pointer:-1,info:-1"
})

local fzf = function(opts)
	local tmp = vim.fn.tempname()
	local bufnr = vim.api.nvim_create_buf(false, true)

	local winnr = vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		row = vim.o.lines,
		col = 0,
		width = vim.o.columns,
		height = math.floor(vim.o.lines / 3),
	})

	local cmd =
		string.format("%s | fzf %s > %s", opts.source, table.concat(opts.options or {}, " "), tmp)

	local on_exit = function()
		vim.api.nvim_win_close(winnr, true)
		local res = vim.fn.readfile(tmp)
		if #res > 0 and opts.sink then
			opts.sink(res[1])
		end
		vim.fn.delete(tmp)
	end

	vim.fn.jobstart(cmd, {
		term = true,
		on_exit = on_exit,
	})

	vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("Files", function()
	fzf {
		source = "fd",
		options = {
			"--cycle",
			"--bind 'ctrl-y:accept'",
			colors,
		},
		sink = vim.cmd.edit,
	}
end, {})

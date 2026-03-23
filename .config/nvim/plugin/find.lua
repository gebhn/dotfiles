vim.pack.add {
	{ src = 'https://github.com/nvim-mini/mini.nvim', name = 'mini' }
}

local e = require 'mini.extra'
local p = require 'mini.pick'

e.setup {}
p.setup {
	mappings = {
		choose = '<C-y>'
	},
	window = {
		config = {
			anchor = 'NW',
			height = math.floor(vim.o.lines * 0.3),
			width = vim.o.columns,
		}
	}
}

vim.keymap.set('n', '<leader>fd', e.pickers.diagnostic, { noremap = true })
vim.keymap.set('n', '<leader>ff', p.builtin.files, { noremap = true })
vim.keymap.set('n', '<leader>fs', p.builtin.grep_live, { noremap = true })

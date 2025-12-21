return {
	cmd = { 'tsgo', '--lsp', '--stdio' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
	},
	root_dir = function(bufnr, on_dir)
		local root_markers = {
			'package-lock.json',
			'yarn.lock',
			'pnpm-lock.yaml',
			'bun.lockb',
			'bun.lock',
		}
		root_markers = { root_markers, { '.git' } }

		if vim.fs.root(bufnr, {
				'deno.json',
				'deno.jsonc',
				'deno.lock',
			}) then
			return
		end

		on_dir(vim.fs.root(bufnr, root_markers) or vim.fn.getcwd())
	end,
}

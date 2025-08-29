function _G.RgFindFiles(cmdarg, _)
    local fnames = vim.fn.systemlist 'rg --files --hidden --color=never --glob="!.git"'
    if #cmdarg == 0 then
        return fnames
    else
        return vim.fn.matchfuzzy(fnames, cmdarg)
    end
end

vim.o.findfunc = 'v:lua.RgFindFiles'

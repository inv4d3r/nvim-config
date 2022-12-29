---- coc plugin ----
vim.fn["minpac#add"]('neoclide/coc.nvim', { ['do'] = '!yarn --frozen-lockfile install' })

---- coc extensions list ----
vim.g.coc_global_extensions = {'coc-git', 'coc-sh', 'coc-json', 'coc-pyright', 'coc-snippets', 'coc-clangd',
                              'coc-markdownlint', 'coc-xml', 'coc-vimlsp', 'coc-cmake', 'coc-explorer',
                              'coc-rust-analyzer', 'coc-tsserver', 'coc-spell-checker', 'coc-cspell-dicts',
                              'coc-sumneko-lua', 'coc-prettier'}

---- coc.nvim configuration ----
vim.g.coc_disable_transparent_cursor = 1
vim.g.coc_default_semantic_highlight_groups = 1
-- use tab for trigger completion with characters ahead and navigate.
-- use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
--[[ inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
--]]

vim.keymap.set("n", "<leader>ge", "<cmd>CocCommand explorer<CR>")
vim.keymap.set("n", "<leader>wi", "<cmd>CocCommand workspace.inspectEdit<CR>")

local coc_explorer_augroup = vim.api.nvim_create_augroup("CocExplorer", { clear = true })
vim.api.nvim_create_autocmd({"StdinReadPre"}, {
  pattern = "*",
  group = coc_explorer_augroup,
  callback = function ()
    vim.s.std_in = 1
  end
})
vim.api.nvim_create_autocmd({"VimEnter"}, {
  pattern = "*",
  group = coc_explorer_augroup,
  callback = function ()
    local argc = vim.fn.argc()
    local is_dir = vim.fn.isdirectory(vim.fn.argv(0)) and not vim.fn.exists("s:std_in")
    if argc == 1 and is_dir  then
      vim.fn.execute("CocCommand explorer")
    end
  end
})

-- use <c-space> for trigger completion.
vim.keymap.set({"i", "n"}, "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- navigate diagnostics
vim.keymap.set("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
vim.keymap.set("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })

-- remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vim.keymap.set("v", "<leader>gav", "<Plug>(coc-codeaction-selected)")
vim.keymap.set("n", "<leader>gav", "<Plug>(coc-codeaction-selected)")

vim.keymap.set("n", "<leader>gal", "<Plug>(coc-codeaction-line)")
vim.keymap.set("n", "<leader>gac", "<Plug>(coc-codeaction-cursor)")

-- remap for do codeAction of current line
vim.keymap.set("n", "<leader>gc", " <Plug>(coc-codeaction)")

-- remap keys for gotos
vim.keymap.set("n", "<leader>gd.", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "<leader>gl.", "<Plug>(coc-declaration)", { silent = true })
vim.keymap.set("n", "<leader>gt.", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "<leader>gi.", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "<leader>gr.", "<Plug>(coc-references)", { silent = true })
vim.keymap.set("n", "<leader>gru", "<Plug>(coc-references-used)", { silent = true })
vim.keymap.set("n", "<leader>grf", "<Plug>(coc-refactor)", { silent = true })

-- standard mappings
vim.keymap.set("n", "<leader>gdd", "<cmd>call CocAction('jumpDefinition', 'drop')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gde", "<cmd>call CocAction('jumpDefinition', 'edit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gdt", "<cmd>call CocAction('jumpDefinition', 'tabe')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gds", "<cmd>call CocAction('jumpDefinition', 'split')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gdv", "<cmd>call CocAction('jumpDefinition', 'vsplit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gld", "<cmd>call CocAction('jumpDeclaration', 'drop')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gle", "<cmd>call CocAction('jumpDeclaration', 'edit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>glt", "<cmd>call CocAction('jumpDeclaration', 'tabe')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gls", "<cmd>call CocAction('jumpDeclaration', 'split')<CR>", { silent = true })
vim.keymap.set("n", "<leader>glv", "<cmd>call CocAction('jumpDeclaration', 'vsplit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gtd", "<cmd>call CocAction('jumpTypeDefinition', 'drop')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gte", "<cmd>call CocAction('jumpTypeDefinition', 'edit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gtt", "<cmd>call CocAction('jumpTypeDefinition', 'tabe')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gts", "<cmd>call CocAction('jumpTypeDefinition', 'split')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gtv", "<cmd>call CocAction('jumpTypeDefinition', 'vsplit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gid", "<cmd>call CocAction('jumpImplementation', 'drop')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gie", "<cmd>call CocAction('jumpImplementation', 'edit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>git", "<cmd>call CocAction('jumpImplementation', 'tabe')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gis", "<cmd>call CocAction('jumpImplementation', 'split')<CR>", { silent = true })
vim.keymap.set("n", "<leader>giv", "<cmd>call CocAction('jumpImplementation', 'vsplit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>grd", "<cmd>call CocAction('jumpReferences', 'drop')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gre", "<cmd>call CocAction('jumpReferences', 'edit')<CR>", { silent = true })
vim.keymap.set("n", "<leader>grt", "<cmd>call CocAction('jumpReferences', 'tabe')<CR>", { silent = true })
vim.keymap.set("n", "<leader>grs", "<cmd>call CocAction('jumpReferences', 'split')<CR>", { silent = true })
vim.keymap.set("n", "<leader>grv", "<cmd>call CocAction('jumpReferences', 'vsplit')<CR>", { silent = true })

-- call hierarchy
vim.keymap.set("n", "<leader>ghi", "<cmd>call CocAction('showIncomingCalls')<CR>", { silent = true })
vim.keymap.set("n", "<leader>gho", "<cmd>call CocAction('showOutgoingCalls')<CR>", { silent = true })

-- type hierarchy
vim.keymap.set("n", "<leader>ghs", "<cmd>call CocAction('showSuperTypes')<CR>", { silent = true })
vim.keymap.set("n", "<leader>ghd", "<cmd>call CocAction('showSubTypes')<CR>", { silent = true })

-- selection range
vim.keymap.set("n", "<leader>ghr", "<Plug>(coc-range-select)", { silent = true })
vim.keymap.set("n", "<leader>ghb", "<Plug>(coc-range-select-backward)", { silent = true })

-- clangd exentions mappings
vim.keymap.set("n", "<leader>gs.", "<cmd>CocCommand clangd.switchSourceHeader<CR>", { silent = true })
vim.keymap.set("n", "<leader>gsd", "<cmd>CocCommand clangd.switchSourceHeader drop<CR>", { silent = true })
vim.keymap.set("n", "<leader>gse", "<cmd>CocCommand clangd.switchSourceHeader edit<CR>", { silent = true })
vim.keymap.set("n", "<leader>gst", "<cmd>CocCommand clangd.switchSourceHeader tabe<CR>", { silent = true })
vim.keymap.set("n", "<leader>gss", "<cmd>CocCommand clangd.switchSourceHeader split<CR>", { silent = true })
vim.keymap.set("n", "<leader>gsv", "<cmd>CocCommand clangd.switchSourceHeader vsplit<CR>", { silent = true })
vim.keymap.set("n", "<leader>gy", "<cmd>CocCommand clangd.symbolInfo<CR>", { silent = true })

-- remap for format selected region
vim.keymap.set({"n", "v"}, "<leader>gf", "<Plug>(coc-format-selected)")

-- show documentation in preview window
local show_documentation = function()
      local ft = vim.bo.filetype
      local cword = vim.fn.expand("<cword>")
      if ft == "vim" then
        vim.fn.execute("h " .. cword)
      else
        vim.fn.CocAction("doHover")
      end
end
vim.keymap.set("n", "<leader>gk", show_documentation, { silent = true })

-- remap for rename current word
vim.keymap.set("n", "<leader>gn", "<Plug>(coc-rename)")

-- fix autofix problem of current line
vim.keymap.set("n", "<leader>gp", "<Plug>(coc-fix-current)")

vim.keymap.set("n", "<leader>go", "<Plug>(coc-codelens-action)")

-- ccls cross references
-- bases
vim.keymap.set("n", "<leader>xb", "<cmd>call CocLocations('ccls','$ccls/inheritance')<cr>", { silent = true })
-- bases of up to 3 levels
vim.keymap.set("n", "<leader>xB", "<cmd>call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>", { silent = true })
-- derived
vim.keymap.set("n", "<leader>xd", "<cmd>call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>", { silent = true })
-- derived of up to 3 levels
vim.keymap.set("n", "<leader>xD", "<cmd>call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>", { silent = true })

-- caller
vim.keymap.set("n", "<leader>xc", "<cmd>call CocLocations('ccls','$ccls/call')<cr>", { silent = true })
-- callee
vim.keymap.set("n", "<leader>xC", "<cmd>call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>", { silent = true })
-- call hierarchy
vim.keymap.set("n", "<leader>xH", "<cmd>call CocLocations('ccls','$ccls/calls')<cr>", { silent = true })

-- $ccls/member
-- member variables / variables in a namespace
vim.keymap.set("n", "<leader>xm", "<cmd>call CocLocations('ccls','$ccls/member')<cr>", { silent = true })
-- member functions / functions in a namespace
vim.keymap.set("n", "<leader>xf", "<cmd>call CocLocations('ccls','$ccls/member',{'kind':3})<cr>", { silent = true })
-- nested classes / types in a namespace
vim.keymap.set("n", "<leader>xs", "<cmd>call CocLocations('ccls','$ccls/member',{'kind':2})<cr>", { silent = true })

vim.keymap.set("n", "<leader>xv", "<cmd>call CocLocations('ccls','$ccls/vars')<cr>", { silent = true })
vim.keymap.set("n", "<leader>xV", "<cmd>call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>", { silent = true })

vim.keymap.set("n", "<leader>xh", "<cmd>call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<CR>", { silent = true })
vim.keymap.set("n", "<leader>xl", "<cmd>call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<CR>", { silent = true })
vim.keymap.set("n", "<leader>xj", "<cmd>call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<CR>", { silent = true })
vim.keymap.set("n", "<leader>xk", "<cmd>call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<CR>", { silent = true })

-- using CocList
-- show all diagnostics
vim.keymap.set("n", "<leader>ha", "<cmd><C-u>CocList diagnostics<cr>", { silent = true })
-- manage extensions
vim.keymap.set("n", "<leader>he", "<cmd><C-u>CocList extensions<cr>", { silent = true })
-- show commands
vim.keymap.set("n", "<leader>hc", "<cmd><C-u>CocList commands<cr>", { silent = true })
-- find symbol of current document
vim.keymap.set("n", "<leader>ho", "<cmd><C-u>CocList outline<cr>", { silent = true })
-- search workspace symbols
vim.keymap.set("n", "<leader>hs", "<cmd><C-u>CocList -I symbols<cr>", { silent = true })
-- do default action for next item.
vim.keymap.set("n", "<leader>hj", "<cmd><C-u>CocNext<CR>", { silent = true })
-- do default action for previous item.
vim.keymap.set("n", "<leader>hk", "<cmd><C-u>CocPrev<CR>", { silent = true })
-- resume latest coc list
vim.keymap.set("n", "<leader>hp", "<cmd><C-u>CocListResume<CR>", { silent = true })

local coc_augroup = vim.api.nvim_create_augroup("Coc", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"typescript", "json"},
  group = coc_augroup,
  callback = function ()
    vim.opt_local.formatexpr = "CocAction('formatSelected')"
  end
})
vim.api.nvim_create_autocmd("User", {
  pattern = "CocJumpPlaceholder",
  group = coc_augroup,
  callback = function ()
    vim.fn.CocActionAsync("showSignatureHelp")
  end
})
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  group = coc_augroup,
  callback = function ()
    vim.fn.CocActionAsync("highlight")
  end
})

-- close preview window when leaving insert mode
--autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

-- Use `:Format` for format current buffer
--command! -nargs=0 Format :call CocAction('format')

-- Use `:Fold` for fold current buffer
--command! -nargs=? Fold :call CocAction('fold', <f-args>)

-- Scroll floating window
vim.keymap.set({"i", "n"}, "<nowait><expr>", "<C-f> coc#float#has_scroll() ? coc#float#scroll(1) : '\\<C-f>'")
vim.keymap.set({"i", "n"}, "<nowait><expr>", "<C-b> coc#float#has_scroll() ? coc#float#scroll(0) : '\\<C-b>'")
vim.keymap.set("n", "<C-w>f", "<cmd>call coc#float#jump()<CR>")

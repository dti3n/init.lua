local lang_maps = {
    cpp = { build = "g++ % -o %:r", exec = "./%:r" },
    java = { build = "javac %", exec = "java %:r" },
    go = { build = "go build", exec = "go run %" },
    typescript = { exec = "tsc" },
    javascript = { exec = "node %" },
    python = { exec = "python3 %" },
	rust = { exec = "cargo run" },
}

for lang, data in pairs(lang_maps) do
	if data.build ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{ command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
		)
	end

	vim.api.nvim_create_autocmd(
		"FileType",
		{ command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
	)
end

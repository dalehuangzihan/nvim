function ColorMyPencils(color)
	vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
	
	-- set color scheme

--	color = color or "gruvbox"
--	vim.cmd("let g:gruvbox_transparent_bg = 1")
	
	color = color or "onedark"
	require("onedarkpro").setup({
		highlights = {
			Comment = { italic = true },
			Directory = { bold = true },
			ErrorMsg = { italic = true, bold = true }
		},
		styles = {
			types = "NONE",
			methods = "NONE",
			numbers = "NONE",
			strings = "NONE",
			comments = "italic",
			keywords = "bold,italic",
			constants = "NONE",
			functions = "italic",
			operators = "NONE",
			variables = "NONE",
			parameters = "NONE",
			conditionals = "italic",
			virtual_text = "NONE",
		}
	})

	vim.cmd.colorscheme(color)

	-- set background to be transparent
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
	
end

ColorMyPencils()

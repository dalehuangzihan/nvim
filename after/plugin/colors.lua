function ColorMyPencils(color)
	-- set color scheme
	color = color -- or "rose-pine"
	vim.cmd.colorscheme(color)

	-- set background to be transparent
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
	
end

ColorMyPencils()

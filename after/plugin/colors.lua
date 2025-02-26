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

--    color = color or "kanagawa"
--    require('kanagawa').setup({
--        compile = false,             -- enable compiling the colorscheme
--        undercurl = true,            -- enable undercurls
--        commentStyle = { italic = true },
--        functionStyle = {},
--        keywordStyle = { italic = true},
--        statementStyle = { bold = true },
--        typeStyle = {},
--        transparent = false,         -- do not set background color
--        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
--        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--        colors = {                   -- add/modify theme and palette colors
--            palette = {},
--            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--        },
--        overrides = function(colors) -- add/modify highlights
--            return {}
--        end,
--        theme = "wave",              -- Load "wave" theme when 'background' option is not set
--        background = {               -- map the value of 'background' option to a theme
--            dark = "dragon",           -- try "dragon" !
--            light = "lotus"
--        },
--    })

	vim.cmd.colorscheme(color)

	-- set background to be transparent
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
	
end

ColorMyPencils()

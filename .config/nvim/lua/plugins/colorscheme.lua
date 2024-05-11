return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
	},
}

return {
	'luukvbaal/statuscol.nvim',
	config = function()
		require('statuscol').setup {
			setopt = true,
			segments = {
				{
					sign = {
						namespace = { 'gitsigns.*' },
						name = { 'gitsigns.*' },
					},
				},
				{
					sign = {
						namespace = { '.*' },
						name = { '.*' },
						auto = true,
					},
				},
				{
					text = {
						function(args)
							return ("%3d %2d").format(args.lnum, args.relnum)
						end },
					click = 'v:lua.ScLa',
				},
			},
		}
	end,
}

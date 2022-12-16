local telescope_setup, telescope = pcall(require, 'telescope')
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, 'telescope.actions')
if not actions_setup then
	return
end

local fb_actions = require('telescope').extensions.file_browser.actions

-- configure telescope
telescope.setup({
	defaults = {
		sorting_strategy = 'ascending',
		-- path_display = {'smart'},
		path_display = { truncate = 6 },
		prompt_prefix = '> ',
		layout_strategy = 'horizontal',
		layout_config = {
			bottom_pane = {
				height = 25,
				preview_cutoff = 120,
				prompt_position = 'top',
			},
			center = {
				height = 0.33,
				preview_cutoff = 0,
				prompt_position = 'top',
				width = 0.95,
				anchor = 'N',
				mirror = true,
			},
			cursor = {
				height = 0.9,
				preview_cutoff = 40,
				width = 0.8,
			},
			horizontal = {
				height = 0.90,
				preview_cutoff = 120,
				prompt_position = 'top',
				width = 0.90,
				preview_width = 0.55,
			},
			vertical = {
				height = 0.95,
				preview_cutoff = 0,
				prompt_position = 'top',
				width = 0.85,
				anchor = 'N',
				mirror = true,
			},
		},
		dynamic_preview_title = true,
		mappings = {
			i = {
				['<C-k>'] = actions.move_selection_previous, -- move to prev result
				['<C-j>'] = actions.move_selection_next, -- move to next result
				['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
	pickers = {
		find_files = {
			-- theme = "dropdown",
		},
	},
	extensions = {
		file_browser = {
			grouped = true,
			initial_mode = 'normal',
			hijack_netrw = true,
			mappings = {
				['i'] = {},
				['n'] = {
					['c'] = false,
					['r'] = false,
					['m'] = false,
					['y'] = false,
					['d'] = false,
					['g'] = false,
					['w'] = false,
					['t'] = false,
					['h'] = false,
					['N'] = fb_actions.create,
					['P'] = fb_actions.goto_parent_dir,
					['R'] = fb_actions.rename,
					['M'] = fb_actions.move,
					['Y'] = fb_actions.copy,
					['D'] = fb_actions.remove,
					['W'] = fb_actions.goto_cwd,
					['H'] = fb_actions.toggle_hidden,
					['T'] = fb_actions.change_cwd,
				},
			},
		},
	},
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
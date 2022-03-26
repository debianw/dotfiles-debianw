local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        -- ["C-j"] = actions.move_selection_next,
        -- ["C-k"] = actions.move_selection_previous,

        ["C-c"] = actions.close,
      }
    }
  },
  extensions = {
    -- fzf = {}
  }
}

telescope.load_extension('fzy_native')

local builtin_status_ok, builtin = pcall(require, "builtin");
if not builtin_status_ok then
  return
end

builtin.live_grep {
  debounce = 100
}

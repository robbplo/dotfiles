local trouble = require("trouble.sources.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open },
      n = { ["<c-t>"] = trouble.open },
    },
  },
}

require('telescope').load_extension('fzf')

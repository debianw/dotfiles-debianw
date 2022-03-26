local nightfox = require('nightfox')

nightfox.setup({
  options = {
    transparent = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = 'italic,bold'
    },
    colors = {
      -- green = "#5cb85c"
    }
  }
})

vim.cmd("colorscheme nightfox")

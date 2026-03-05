require("dressing").setup(
  {
    input = {
      border = "single",
    },
    select = {
      backend = { "telescope", "builtin" },
      telescope = require("telescope.themes").get_cursor({
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      }),
      builtin = {
        border = "single",
      },
    },
  }
)

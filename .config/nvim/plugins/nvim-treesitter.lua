require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    colors = {
      -- https://github.com/joshdick/onedark.vim/blob/main/colors/onedark.vim
      '#98c379', -- green
      '#c678dd', -- magenta
      '#e5c07b', -- yellow
      '#e06c75', -- light red
      '#61afef', -- blue
    },
    termcolors = {
      -- https://github.com/joshdick/onedark.vim/blob/main/autoload/onedark.vim
      '114', -- green
      '170', -- purple
      '173', -- dark_yellow
      '204', -- red
      '39', -- blue
    }
  }
}

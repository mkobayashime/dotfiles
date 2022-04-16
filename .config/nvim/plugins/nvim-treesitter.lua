require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'cpp',
    'css',
    'dockerfile',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'make',
    'markdown',
    'regex',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    colors = {
      -- https://github.com/joshdick/onedark.vim/blob/main/colors/onedark.vim
      '#7ee787', -- green
      '#da99ff', -- magenta
      '#e3b341', -- yellow
      '#ff7a90', -- light red
      '#58a6ff', -- blue
    },
    termcolors = {
      -- https://github.com/joshdick/onedark.vim/blob/main/autoload/onedark.vim
      '114', -- green
      '170', -- purple
      '173', -- dark_yellow
      '204', -- red
      '39', -- blue
    }
  },
  playground = {
    enable = true,
  },
}

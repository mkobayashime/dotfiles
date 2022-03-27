local patterns_typescript = {
  'export',
  'type',
  'interface',
  'namespace',
}

require('treesitter-context').setup({
  patterns = {
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
    },
    typescript = patterns_typescript,
    typescriptreact = patterns_typescript,
  }
})

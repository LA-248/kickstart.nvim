return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
      'DiffviewClose',
      'DiffviewFileHistory',
      'DiffviewFocusFiles',
      'DiffviewOpen',
      'DiffviewRefresh',
      'DiffviewToggleFiles',
    },
    keys = {
      {
        '<C-S-A-D-d>',
        function()
          if require('diffview.lib').get_current_view() then
            vim.cmd 'DiffviewClose'
          else
            vim.cmd 'DiffviewOpen'
          end
        end,
        desc = 'Diffview toggle (Hyper+D)',
      },
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff view' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = '[G]it close [D]iff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it repository [H]istory' },
    },
    opts = {},
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      {
        '<C-S-A-D-b>',
        '<cmd>ToggleTerm direction=horizontal<cr>',
        mode = { 'n', 't' },
        desc = 'Toggle terminal (Hyper+B)',
      },
    },
    opts = {
      size = 25,
    },
  },
  -- nvim v0.8.0
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<C-S-A-D-v>', '<cmd>LazyGit<cr>', desc = 'LazyGit (Hyper+V)' },
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    keys = {
      { '<C-S-A-D-k>', '<cmd>Neotree toggle position=float reveal<cr>', desc = 'Toggle Neo-tree (Hyper+k)', silent = true },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    opts = {
      window = {
        position = 'float',
      },
    },
  },
}

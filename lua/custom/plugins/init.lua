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
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = '[H]arpoon [A]dd file' })

      vim.keymap.set('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon menu' })

      vim.keymap.set('n', '<leader>h1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon file 1' })

      vim.keymap.set('n', '<leader>h2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon file 2' })
    end,
  },
  {
    'mluders/comfy-line-numbers.nvim',
    opts = {},
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'emrearmagan/atlas.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional but recommended
      'esmuellert/codediff.nvim', -- optional (PullRequest diff)
      'sindrets/diffview.nvim', -- optional; or "dlyongemallo/diffview-plus.nvim"
    },
    -- See Configuration below
    ---@type AtlasConfig
    opts = {
      ui = {
        -- Set either to false to keep your existing statusline.
        statusline = {
          atlas = true, -- Dashboards, details, and other non-diff Atlas views.
          diff = true, -- Diff and review views.
        },
        -- "auto", "default", "snacks", or "fzf-lua".
        picker = 'snacks',
        -- Make the main Atlas dashboard a listed buffer.
        listed_buffer = false,
      },

      providers = {
        ---@type AtlasGitHubConfig
        github = {
          hostname = 'github.com', -- Defaults to GH_HOST, then github.com.
          cache_ttl = 300, -- Set to 0 to disable caching.
        },
      },

      -- See Pulls Configuration below.
      pulls = {
        delete_notes = false, -- Delete notes after approval or merge.
        default_merge_method = 'merge', -- "merge" or "squash".
        default_delete_source_branch = false,
        git_transport = 'https', -- "https" or "ssh" for Atlas-managed Git remotes.

        description = {
          include_summary = true,
          include_commit_hashes = true,
          include_related = true,
          include_diffstat = false,
        },

        -- Replaces the built-in Conventional Comments templates.
        comment_templates = {
          insert_mode = true, -- Enter Insert mode after applying a template.
          items = {
            { label = 'Suggestion', text = 'suggestion: ' },
            { label = 'Issue', text = 'issue: ' },
            { label = 'Nitpick', text = 'nitpick: ' },
          },
        },

        diff = {
          -- "auto", or a command that accepts explicit <base>...<head> Git revisions.
          open_cmd = 'AtlasDiff', -- CodeDiff, DiffviewOpen or AtlasDiff
          comment_display = 'virtual_lines', -- "virtual_lines" or compact "virtual_text" hints.
          review_panel = {
            hidden = true, -- Set false to show the review panel when a diff opens.
            height = 10,
          },

          -- AtlasDiff options; external viewers use their own configuration.
          layout = 'inline', -- "inline" or "side-by-side".
          compact = true, -- Start with only changed hunks and surrounding context visible.
          lsp = {
            -- Back the new side of the diff with a detached worktree at the PR head so it is made of
            -- real files and your language servers attach to it (AtlasDiff and CodeDiff). Off by default.
            enabled = true,
            -- Defaults to `stdpath("cache")/atlas/worktrees/<repo>/pr-<id>` (or `<repo>/<sha>` without a PR).
            -- May be an absolute path, or a function receiving
            -- { repo_root, repo_full_name, pr_id, head_sha, default } that returns a path or nil.
            dir = nil,
            -- Directories symlinked from your checkout into the worktree so servers can resolve
            -- dependencies. These are the same directories on disk, not copies.
            link = {}, -- e.g. { "node_modules", ".venv" }
          },
          explorer = {
            grouped = true, -- Group changed files by directory.
            hidden = false,
            show_commits = false, -- Set true to show commits below changed files initially.
            width = 40,
            initial_focus = 'explorer', -- "explorer" or "diff".
            preview = false, -- Show a file as soon as the explorer cursor moves onto it.
            focus_on_select = false, -- Move into the diff after selecting a file.
            ignore = { '.git/**', '.jj/**' },
          },
        },
        repo_config = {
          -- Maps `namespace/repo` to local paths. Used for checkout, diffs, and custom actions.
          paths = {
            ['LA-248/relay'] = '~/Dropbox/Code/Projects/relay',
          },
        },
        custom_actions = {}, -- See :help atlas-custom-actions.
      },

      -- See Issue Configuration below.
      issues = {},
    },
  },
}

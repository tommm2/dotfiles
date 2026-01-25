return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
  },
}

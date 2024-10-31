{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = true;
      signcolumn = true;
      signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "-";
        untracked.text = "┆";
      };
      watch_gitdir.follow_files = true;
    };
  };
}

{
  programs.nixvim.plugins.floaterm = {
    enable = true;
    borderchars = "─│─│╭╮╯╰";
    height = 0.9;
    width = 0.9;
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" "i" "v" ];
      action = "<cmd>FloatermNew --disposable --title=lazygit lazygit<cr>";
      key = "<leader>lg";
      options.desc = "LazyGit";
    }
    {
      mode = [ "n" "i" "v" ];
      action =
        "<cmd>FloatermNew --disposable --title=lazydocker lazydocker<cr>";
      key = "<leader>ld";
      options.desc = "LazyDocker";
    }
    {
      mode = [ "n" "i" "v" ];
      action =
        "<cmd>FloatermNew --disposable --title=lazydocker lazydocker<cr>";
      key = "<leader>ld";
      options.desc = "LazyDocker";
    }
    {
      mode = [ "n" "i" "v" ];
      action = "<cmd>FloatermToggle --title=terminal<cr>";
      key = "<C-/>";
      options.desc = "Terminal";
    }
  ];
}

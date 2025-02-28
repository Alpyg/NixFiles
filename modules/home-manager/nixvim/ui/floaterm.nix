{
  programs.nixvim.plugins.floaterm = {
    enable = true;
    settings = {
      borderchars = "─│─│╭╮╯╰";
      height = 0.9;
      width = 0.9;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" "i" "v" ];
      key = "<leader>lg";
      action = "<cmd>FloatermNew --disposable --title=lazygit lazygit<cr>";
      options.desc = "LazyGit";
    }
    {
      mode = [ "n" "i" "v" ];
      key = "<leader>ld";
      action =
        "<cmd>FloatermNew --disposable --title=lazydocker lazydocker<cr>";
      options.desc = "LazyDocker";
    }
    {
      mode = [ "n" "i" "v" ];
      key = "<leader>ld";
      action =
        "<cmd>FloatermNew --disposable --title=lazydocker lazydocker<cr>";
      options.desc = "LazyDocker";
    }
    {
      mode = [ "n" "i" "v" "t" ];
      key = "<C-/>";
      action = "<cmd>FloatermToggle --title=terminal<cr>";
      options.desc = "Terminal";
    }
  ];
}

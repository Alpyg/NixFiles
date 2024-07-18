{
  programs.nixvim.plugins.which-key = {
    enable = true;

    registrations = {
      "<leader>c" = "code";
      "<leader>f" = "file/find";
      "<leader>l" = "lazy";
      "<leader>s" = "search";
      "<leader>w" = "windows";
      "<leader>x" = "diagnostics/quickfix";
      "<leader>g" = "goto";
      "<leader>gs" = "surround";
      "<leader>z" = "fold";
    };
  };
}

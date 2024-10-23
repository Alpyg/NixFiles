{
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = "mocha";

      integrations = {
        cmp = true;
        gitsigns = true;
        mini = {
          enabled = true;
          indentschope_color = "";
        };
        treesitter = true;
      };

      styles = {
        booleans = ["bold" "italic"];
        conditionals = ["bold"];
      };

      term_colors = true;
    };
  };
}

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
        neotree = true;
        telescope = true;
        treesitter = true;
        which_key = true;
      };

      styles = {
        booleans = [ "bold" "italic" ];
        conditionals = [ "bold" ];
      };

      term_colors = true;
    };
  };
}

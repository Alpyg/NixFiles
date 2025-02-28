{
  programs.nixvim.plugins.which-key = {
    enable = true;

    settings.spec = [
      {
        __unkeyed-1 = "<leader>c";
        group = "Code";
        icon = " ";
      }
      {
        __unkeyed-1 = "<leader>f";
        group = "File/Find";
        icon = "󰍉 ";
      }
      {
        __unkeyed-1 = "<leader>l";
        group = "Lazy";
        icon = "󰒡 ";
      }
      {
        __unkeyed-1 = "<leader>s";
        group = "Search";
        icon = "󰍉 ";
      }
      {
        __unkeyed-1 = "<leader>w";
        group = "Windows";
        icon = " ";
      }
      {
        __unkeyed-1 = "<leader>x";
        group = "Diagnostics/Quickfix";
        icon = " ";
      }
      {
        __unkeyed-1 = "<leader>g";
        group = "Goto";
        icon = "󰅚 ";
      }
      {
        __unkeyed-1 = "<leader>gs";
        group = "Surround";
        icon = "󰄬 ";
      }
      {
        __unkeyed-1 = "<leader>z";
        group = "Fold";
        icon = " ";
      }
      {
        __unkeyed-1 = "<leader>r";
        group = "Refactoring";
        icon = " ";
      }
    ];
  };
}

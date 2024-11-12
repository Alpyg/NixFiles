{ config, ... }: {
  programs.nixvim = {
    keymaps = let
      elemAtOrDefault = list: index:
        (if index >= 0 && index < builtins.length list then
          builtins.elemAt list 3
        else
          { });
      maps = map (x: {
        mode = builtins.elemAt x 0;
        key = builtins.elemAt x 1;
        action = builtins.elemAt x 2;
        options = elemAtOrDefault x 3;
      }) [
        [ "n" "<esc>" "<cmd>noh<cr>" ] # clear search results
        [ "n" "Y" "y$" ] # fix Y behavior
        [
          "n"
          "<C-c>"
          "<cmd>b#<cr>"
        ] # back and forth between the two most recent files
        [
          "n"
          "<C-x>"
          "<cmd>close<cr>"
        ] # close by ctrl-x

        # save
        [ "n" "<leader>s" "<cmd>w<cr>" ]
        [
          [ "n" "i" "v" ]
          "<C-s>"
          "<cmd>w<cr>"
        ]

        # quit
        [
          [ "n" "i" "v" ]
          "<leader>qq"
          "<cmd>qa!<cr>"
          { desc = "Close neovim"; }
        ]

        # navigation
        [ "n" "<leader>h" "<C-w>h" { desc = "Navigate to right window"; } ]
        [
          "n"
          "<leader>l"
          "<C-w>l"
          { desc = "Navigate to left window"; }
        ]

        # jump start/end of line (first/last character)
        [ "n" "H" "^" { desc = "Jump to start of line"; } ]
        [
          "n"
          "L"
          "$"
          { desc = "Jump to end of line"; }
        ]

        # resize with arrows
        [ "n" "<C-Up>" "<cmd>resize -2<cr>" { desc = "Resize up"; } ]
        [ "n" "<C-Down>" "<cmd>resize +2<cr>" { desc = "Resize down"; } ]
        [
          "n"
          "<C-Right>"
          "<cmd>vertical resize -2<cr>"
          { desc = "Resize right"; }
        ]
        [
          "n"
          "<C-Left>"
          "<cmd>vertical resize +2<cr>"
          { desc = "Resize left"; }
        ]

        # move current line up/down
        [ "n" "<M-k>" "<cmd>move-2<cr>" ]
        [ "n" "<M-j>" "<cmd>move+<cr>" ]

        [
          "n"
          "<leader>rp"
          "<cmd>!remi push<cr>"
        ]

        # better indenting
        [ "v" ">" ">gv" ]
        [ "v" "<" "<gv" ]
        [ "v" "<TAB>" ">gv" ]
        [
          "v"
          "<S-TAB>"
          "<gv"
        ]
        # move selected line/block in visual mode
        [ "v" "K" "<cmd>m '<-2<cr>gv=gv" ]
        [ "v" "J" "<cmd>m '<+1<cr>gv=gv" ]
      ];
    in config.lib.nixvim.keymaps.mkKeymaps { options.silent = true; } maps;
  };
}

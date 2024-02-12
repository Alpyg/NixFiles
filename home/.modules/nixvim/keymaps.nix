{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      elemAtOrDefault = list: index: (
        if index >= 0 && index < builtins.length list
        then builtins.elemAt list 3
        else {}
      );
      maps = map (x: {
        mode =  builtins.elemAt x 0;
        key = builtins.elemAt x 1;
        action = builtins.elemAt x 2;
        options = elemAtOrDefault x 3;
      }) [
[ "n" "<Space>" "<NOP>" {} ]
[ "n" "<esc>" ":noh<CR>" ] # clear search results
[ "n" "Y" "y$" ] # fix Y behavior
[ "n" "<C-c>" ":b#<CR>" ] # back and forth between the two most recent files
[ "n" "<C-x>" ":close<CR>" ] # close by ctrl-x

# save
[ "n" "<leader>s" ":w<CR>" ]
[ "n" "<C-s>" ":w<CR>" ]

# navigation
[ "n" "<leader>h" "<C-w>h" { desc = "Navigate to right window"; } ]
[ "n" "<leader>l" "<C-w>l" { desc = "Navigate to left window"; } ]

# jump start/end of line (first/last character)
[ "n" "H" "^" { desc = "Jump to start of line"; } ]
[ "n" "L" "$" { desc = "Jump to end of line"; } ]

# resize with arrows
[ "n" "<C-Up>" ":resize -2<CR>" { desc = "Resize up"; } ]
[ "n" "<C-Down>" ":resize +2<CR>" { desc = "Resize down"; } ]
[ "n" "<C-Right>" ":vertical resize -2<CR>" { desc = "Resize right"; } ]
[ "n" "<C-Left>" ":vertical resize +2<CR>" { desc = "Resize left"; } ]

# move current line up/down
[ "n" "<M-k>" ":move-2<CR>" ]
[ "n" "<M-j>" ":move+<CR>" ]

[ "n" "<leader>rp" ":!remi push<CR>" ]

# better indenting
[ "v" ">" ">gv" ]
[ "v" "<" "<gv" ]
[ "v" "<TAB>" ">gv" ]
[ "v" "<S-TAB>" "<gv" ]
# move selected line/block in visual mode
[ "v" "K" ":m '<-2<CR>gv=gv" ]
[ "v" "J" ":m '<+1<CR>gv=gv" ]

# lazygit/docker
[["n" "i" "v"] "<leader>lg" "<cmd>FloatermNew --width=0.9 --height=0.9 --name=lazygit lazygit<CR>" { desc = "Open LazyGit"; } ]
[["n" "i" "v"] "<leader>ld" "<cmd>FloatermNew --width=0.9 --height=0.9 --name=lazydocker lazydocker<CR>" { desc = "Open LazyDocker"; } ]

# Ollama
[["n" "i" "v"] "<leader>og" ":<C-u>lua require('ollama').prompt('Generate_Code')<CR>" { desc = "Ollama generate code"; } ]
[["n" "i" "v"] "<leader>oo" ":<C-u>lua require('ollama').prompt()<CR>" { desc = "Ollama prompt"; } ]
      ];
    in
      config.nixvim.helpers.keymaps.mkKeymaps
      {options.silent = true;}
      (maps);
  };
}

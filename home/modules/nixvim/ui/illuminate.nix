{
  programs.nixvim.plugins.illuminate = {
    enable = true;

    filetypesDenylist = [ "neo-tree" "TelescopePrompt" ];

    largeFileCutoff = 3000;
  };
}

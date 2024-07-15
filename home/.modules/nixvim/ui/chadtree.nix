{
  programs.nixvim.plugins.chadtree = {
    enable = true;

    options = {
      showHidden = true;
      pollingRate = 0.5;
    };
  };
}

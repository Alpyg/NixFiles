{ ... }: {
  programs.nixvim.plugins.dap = {
    enable = true;

    extensions.dap-ui.enable = true;
    extensions.dap-virtual-text.enable = true;

    extensions.dap-python.enable = true;
  };
}

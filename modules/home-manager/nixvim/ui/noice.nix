{
  programs.nixvim.plugins.noice = {
    enable = true;

    settings = {
      notify.enabled = true;
      messages.enabled = true;
      popupmenu.enabled = true;

      lsp = {
        message.enabled = false;
        progress.enabled = false;
      };
    };
  };
}

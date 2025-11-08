{
  programs.nixcord = {
    enable = true;
    config = {
      enabledThemes = [];
      # themeLinks =
      #   "https://raw.githubusercontent.com/catppuccin/discord/refs/heads/main/themes/mocha.theme.css"
      # ];
      frameless = true;
      plugins = {
        betterFolders.enable = true;
        betterRoleContext.enable = true;
        betterRoleDot.enable = true;
        callTimer.enable = true;
        crashHandler.enable = true;
        fakeNitro.enable = true;
        imageZoom.enable = true;
        memberCount.enable = true;
        messageLogger = {
          enable = true;
          ignoreSelf = true;
          ignoreBots = true;
        };
        typingIndicator.enable = true;
        silentTyping.enable = true;
      };
    };
  };
}

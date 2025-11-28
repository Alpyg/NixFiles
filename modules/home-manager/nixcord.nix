{
  programs.nixcord = {
    enable = true;
    config = {
      enabledThemes = [];
      frameless = true;
      plugins = {
        betterFolders.enable = true;
        betterRoleContext.enable = true;
        betterRoleDot.enable = true;
        callTimer.enable = true;
        crashHandler.enable = true;
        fakeNitro.enable = true;
        imageZoom = {
          enable = true;
          zoom = 3.0;
          size = 700.0;
        };
        memberCount.enable = true;
        messageLogger = {
          enable = true;
          ignoreSelf = true;
          ignoreBots = true;
        };
        pinDMs.enable = true;
        silentTyping.enable = true;
        typingIndicator.enable = true;
      };
    };
  };
}

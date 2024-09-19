{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;

      servers = {
        docker-compose-language-service.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        html.enable = true;
        intelephense.enable = true;
        java-language-server.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        pylsp.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        tailwindcss.enable = true;
        ts-ls.enable = true;
        zls.enable = true;
      };
    };
  };
}

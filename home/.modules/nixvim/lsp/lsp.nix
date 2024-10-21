{ pkgs, ... }: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;

      servers = {
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        html.enable = true;
        intelephense = {
          enable = true;
          package = pkgs.intelephense;
        };
        java_language_server.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        pylsp.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        tailwindcss.enable = true;
        ts_ls.enable = true;
        zls.enable = true;
      };
    };
  };
}

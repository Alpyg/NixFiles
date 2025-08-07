{ lib, config, ... }: {
  options.ollama.enable = lib.mkEnableOption "Enable Ollama";

  config = lib.mkIf config.ollama.enable {
    services.ollama = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      
      acceleration = "cuda";

      loadModels = [ "deepseek-r1:7b" ];
    };
  };
}

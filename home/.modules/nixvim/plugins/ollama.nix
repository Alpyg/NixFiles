{
  programs.nixvim.plugins.ollama = {
    enable = true;

    model = "deepseek-coder";

    serve = {
      onStart = true;
      command = "docker";
      args = ["start" "ollama"];

      stopCommand = "docker";
      stopArgs = ["stop" "ollama"];
    };
  };
}

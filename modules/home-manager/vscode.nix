{ pkgs, lib, config, ... }: {

  options.vscode.enable = lib.mkEnableOption "Enable vscode";

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        rust-lang.rust-analyzer
        golang.go
        ziglang.vscode-zig
        ms-python.python
        ms-python.debugpy
        devsense.phptools-vscode

        github.vscode-pull-request-github
        github.copilot
        github.copilot-chat
        eamodio.gitlens
        tamasfe.even-better-toml
        fill-labs.dependi
        arrterian.nix-env-selector

        catppuccin.catppuccin-vsc
      ];
    };
  };
}

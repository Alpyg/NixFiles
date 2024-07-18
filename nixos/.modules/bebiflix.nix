{ ... }:

{
  services.deluge = {
    enable = true;
    openFirewall = true;
    user = "nexus";
    web.enable = true;
  };
}

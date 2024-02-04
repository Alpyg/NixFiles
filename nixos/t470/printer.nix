{ ... }:

{
  services.klipper = {
    enable = true;
    configFile = "/home/alpyg/klipper.cfg";
  };
  services.moonraker = {
    enable = true;
    user = "root";
    address = "0.0.0.0";
    settings = {
      authorization = {
        force_logins = false;
        cors_domains = [ "localhost" "*.local" ];
        trusted_clients = [ "0.0.0.0" "127.0.0.1" "192.168.2.0/24" "10.147.20.0/24" ];
      };
    };
  };
  services.mainsail = {
    enable = true;
  };
}

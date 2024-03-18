{ ... }:

{
  services.static-web-server = {
    enable = true;
    root = "/home/alpyg/Downloads";
    configuration = { general = { directory-listing = true; }; };
  };
}

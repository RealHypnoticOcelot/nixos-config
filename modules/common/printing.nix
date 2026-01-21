{ pkgs, ... }:

{
  avahi = {
    # Daemon that allows for automatic discovery of services on local networks
    # In this case, it's a prerequisite for automatically finding printers on the network
    enable = true;
    nssmdns4 = true;
    # mDNS Name Server Switch plugin, allows for applications to resolve devices on the .local domain
  }; # By enabling Avahi, we now search on UDP port 5353 for printers
  printing = {
    enable = true;
    drivers = with pkgs; [
    cups-filters # Includes "filters", which are used to convert data into a printer-receivable format
    cups-browsed # A helper daemon to Avahi that helps with printer discovery
    ];
  };
}
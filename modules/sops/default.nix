{ userName, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml; # Secrets encrypted with the public key
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${userName}/.config/sops/age/keys.txt";
  };
}
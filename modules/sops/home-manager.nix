{ userName, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml; # Secrets encrypted with the public key
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${userName}/.config/sops/age/keys.txt";
    secrets = {
      git_email = {};
    }
  };
}
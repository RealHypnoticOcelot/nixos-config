{ pkgs, config, ... }:

{
  packages = with pkgs; [
    prismlauncher
  ];
}
{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.maxine = {
    isNormalUser = true;
    home = "/home/maxine";
    extraGroups = [ "docker" "lxd" "wheel" ];
    shell = pkgs.fish;
    password = "maxine";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIORLlt16O7tEDuiBbcgvabtfjTcKI6MoetPdaTXfK5TL maxine"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    # (import ./vim.nix { inherit inputs; })
  ];
}

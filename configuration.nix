{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.hostId = "a3f9c2b1";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Guayaquil";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = /etc/kbd/keymaps/i386/qwerty/la-latin1.map.gz;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.libinput.enable = true;
  services.xserver.enable = true;
  services.xserver.xkb.layout = "latam";
  services.xserver.exportConfiguration = true;

  users.users.brauliorivas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  users = {
    defaultUserShell = pkgs.zsh;
    groups = {
      shared = { gid = 2000; };
    };
  };

  programs = {
    hyprland.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    xkeyboard-config
    brave
    neovim
    git
    yazi
    bat
    zoxide
    tmux
    oh-my-posh
    ripgrep
    fd
    clojure
    gcc
    gnumake
    cmake
    tree-sitter
  ];
  
  system.copySystemConfiguration = true;

  system.stateVersion = "25.11";
}


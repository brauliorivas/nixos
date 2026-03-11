{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
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
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
  };
  services.libinput.enable = true;
  services.xserver.enable = true;
  services.xserver.xkb.layout = "latam";
  services.xserver.exportConfiguration = true;
  services.upower.enable = true;

  users.users.brauliorivas = {
    packages = with pkgs; [
      fastfetch
      swaybg
      clojure
      clojure-lsp
      stylua
      nixfmt
      nixd
      nodejs_24
      gleam
      go
      gopls
      lua5_4_compat
      lua-language-server
      python314
      plocate
      glow
      duf
    ];
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "shared"
    ];
  };

  users = {
    defaultUserShell = pkgs.zsh;
    groups = {
      shared = {
        gid = 2000;
      };
    };
  };

  programs = {
    hyprland.enable = true;
    zsh.enable = true;
    xwayland.enable = true;
  };
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = "*";
        hyprland.default = [
          "hyprland"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
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
    tmux
    oh-my-posh

    zoxide
    ripgrep
    fd
    btop
    procs
    delta
    bat
    eza

    gcc
    gnumake
    cmake
    tree-sitter

    pnpm
    ashell
    sddm-astronaut

    nwg-look
    rofi
    hyprpolkitagent
    dunst
    hyprpicker
    wl-clipboard
    nautilus
    andromeda-gtk-theme
    numix-icon-theme
  ];

  system.copySystemConfiguration = true;
  system.stateVersion = "25.11";
}

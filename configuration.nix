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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
      stylua
      nixfmt
      nixd
      lua5_4_compat
      lua-language-server
      tdf
      plocate
      glow
      duf
      kitty
      brave
      neovim
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
      tree-sitter
      grim
      swappy
      slurp
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
    direnv.enable = true;
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
    xkeyboard-config
    git

    ashell
    sddm-astronaut
    nwg-look
    dunst
    swaybg
    hyprpicker
    wofi
    hypridle
    hyprlock
    hyprpolkitagent
    wl-clipboard
    cliphist
    nautilus
    andromeda-gtk-theme
    numix-icon-theme
  ];

  system.copySystemConfiguration = true;
  system.stateVersion = "25.11";
}

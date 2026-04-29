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

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "github-copilot-cli"
      "claude-code"
      "google-chrome"
    ];

  virtualisation.docker = {
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
    };
  };

  users.users.brauliorivas = {
    linger = true;
    packages =
      let
        unstable =
          import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz")
            {
              config = config.nixpkgs.config;
            };
      in
      with pkgs;
      [
        # Languages
        nixfmt
        nixd
        lua5_4_compat
        lua-language-server
        stylua
        typst
        typstyle
        # Dev tools
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
        fastfetch
        plocate
        yazi
        uv
        tree
        # Programs
        firefox
        kitty
        pidgin
        unstable.neovim
        unstable.opencode
        unstable.claude-code
        unstable.github-copilot-cli
        unstable.ollama
        unstable.codex
        unstable.gemini-cli
        gh
        jq
        lsof
        tdf
        glow
        duf
        tree-sitter
        grim
        swappy
        slurp
        google-cloud-sdk
        google-chrome
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
    nix-ld.enable = true;
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

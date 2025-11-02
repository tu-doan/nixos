{ pkgs, ... }:

{
  imports = [
    ./language.nix
  ];

  users.users.tudoan = {
    isNormalUser = true;
    description = "Tu Doan";
    extraGroups = [
      "docker"
      "libvirtd"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      aria
      fd
      ffmpeg
      fzf
      gcc
      gh
      gnome-sound-recorder
      gpu-screen-recorder
      jq
      kdePackages.kdeconnect-kde
      kubectl
      kubernetes-helm
      kustomize
      rclone
      ripgrep
      zoxide

      brave
      discord-ptb
      firefox-wayland
      signal-desktop
      slack
      telegram-desktop
      vscode
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.tudoan = {
      home = {
        stateVersion = "25.05";
      };
      services = {
        easyeffects.enable = true;
      };
      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk = {
        enable = true;
        font.name = "MesloLGS Nerd Font Mono";
        font.size = 12;
        theme = {
          package = pkgs.arc-theme;
          name = "Arc-Dark";
        };
        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus";
        };
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };
    };
  };
}

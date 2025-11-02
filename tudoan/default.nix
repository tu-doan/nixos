{ pkgs, ... }:

{
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
      brave
      discord-ptb
      fd
      ffmpeg
      fzf
      gh
      go
      jq
      kubectl
      kubernetes-helm
      kustomize
      nodePackages.npm
      nodePackages.yarn
      nodejs
      rclone
      ripgrep
      zoxide

      lua-language-server

      firefox-wayland
      gnome-sound-recorder
      gpu-screen-recorder
      kdePackages.kdeconnect-kde
      slack
      signal-desktop
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

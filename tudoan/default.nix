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
      kitty
      foot
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
      ripgrep
      zoxide

      lua-language-server
      terraform-ls

      firefox-wayland
      gnome-sound-recorder
      gpu-screen-recorder
      kdePackages.kdeconnect-kde
      slack
      signal-desktop
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
        theme = {
          package = pkgs.arc-theme;
          name = "Arc-Dark";
        };
        iconTheme = {
          package = pkgs.arc-icon-theme;
          name = "Arc";
        };
      };
    };
  };
}

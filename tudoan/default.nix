{ pkgs, ... }:

{
  imports = [
    ./language.nix
    ./nordvpn.nix
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
      # CLI
      aria
      awscli2
      claude-code
      dig
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
      mtr
      pritunl-client
      rclone
      ripgrep
      traceroute
      zoxide

      # GUI
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
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
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

  tudoan.services.custom.nordvpn.enable=true;

}
